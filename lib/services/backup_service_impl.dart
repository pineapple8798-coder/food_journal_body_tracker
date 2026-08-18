import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../models/models.dart';
import '../repositories/advice_repository_impl.dart';
import '../repositories/feedback_repository_impl.dart';
import '../repositories/meal_repository_impl.dart';
import 'backup_service.dart';

class BackupServiceImpl implements BackupService {
  BackupServiceImpl({
    required this.mealRepo,
    required this.feedbackRepo,
    required this.adviceRepo,
  });

  final MealRepositoryImpl mealRepo;
  final FeedbackRepositoryImpl feedbackRepo;
  final AdviceRepositoryImpl adviceRepo;

  @override
  Future<File> exportAll() async {
    final meals = await _loadAllMeals();
    final feedbacks = await _loadAllFeedbacks();
    final advices = await adviceRepo.getAdviceHistory(limit: 100000);

    final payload = {
      'version': 1,
      'exported_at': DateTime.now().toIso8601String(),
      'meals': meals.map(_mealToJson).toList(),
      'feedbacks': feedbacks.map(_feedbackToJson).toList(),
      'advices': advices.map(_adviceToJson).toList(),
    };

    final tmpDir = await Directory.systemTemp.createTemp('backup');
    final file = File(p.join(tmpDir.path, 'food_journal_backup.json'));
    await file.writeAsString(jsonEncode(payload));
    return file;
  }

  @override
  Future<void> importFrom(File file) async {
    final content = await file.readAsString();
    final Map<String, dynamic> payload;
    try {
      payload = jsonDecode(content) as Map<String, dynamic>;
    } catch (_) {
      throw FormatException('备份文件格式无效');
    }

    if (payload['version'] != 1) {
      throw FormatException('不支持的备份版本');
    }

    final meals = (payload['meals'] as List<dynamic>? ?? const [])
        .map((e) => _mealFromJson(e as Map<String, dynamic>))
        .toList();
    final feedbacks = (payload['feedbacks'] as List<dynamic>? ?? const [])
        .map((e) => _feedbackFromJson(e as Map<String, dynamic>))
        .toList();
    final advices = (payload['advices'] as List<dynamic>? ?? const [])
        .map((e) => _adviceFromJson(e as Map<String, dynamic>))
        .toList();

    for (final meal in meals) {
      await mealRepo.saveMeal(meal);
    }
    for (final feedback in feedbacks) {
      await feedbackRepo.saveFeedback(feedback);
    }
    for (final advice in advices) {
      await adviceRepo.saveAdvice(advice);
    }
  }

  Future<List<MealRecord>> _loadAllMeals() async {
    final result = <MealRecord>[];
    final now = DateTime.now();
    for (var i = 0; i < 3650; i++) {
      final date = now.subtract(Duration(days: i));
      final meals = await mealRepo.getMealsByDate(date);
      result.addAll(meals);
    }
    return result;
  }

  Future<List<BodyFeedback>> _loadAllFeedbacks() async {
    final result = <BodyFeedback>[];
    final now = DateTime.now();
    for (var i = 0; i < 3650; i++) {
      final date = now.subtract(Duration(days: i));
      final feedback = await feedbackRepo.getFeedbackByDate(date);
      if (feedback != null) result.add(feedback);
    }
    return result;
  }

  Map<String, dynamic> _mealToJson(MealRecord meal) => {
        'date': meal.dateKey,
        'meal_type': meal.mealType.name,
        'food_items': meal.foodItems
            .map(
              (f) => {
                'image_path': f.imagePath,
                'name': f.name,
                'comment': f.comment,
                'ai_recognized': f.aiRecognized,
                'ai_confidence': f.aiConfidence,
              },
            )
            .toList(),
      };

  Map<String, dynamic> _feedbackToJson(BodyFeedback feedback) => {
        'date': feedback.dateKey,
        'energy_score': feedback.energyScore,
        'digestion_score': feedback.digestionScore,
        'sleep_score': feedback.sleepScore,
        'stomach_score': feedback.stomachScore,
        'skin_score': feedback.skinScore,
        'weight': feedback.weight,
        'note': feedback.note,
        'symptoms': feedback.symptoms
            .map(
              (s) => {
                'type': s.type.name,
                'severity': s.severity.name,
              },
            )
            .toList(),
      };

  Map<String, dynamic> _adviceToJson(AdviceRecord advice) => {
        'query_text': advice.queryText,
        'query_image_path': advice.queryImagePath,
        'conclusion': advice.conclusion.name,
        'reason': advice.reason,
        'risk_factors': advice.riskFactors,
        'created_at': advice.createdAt.toIso8601String(),
      };

  MealRecord _mealFromJson(Map<String, dynamic> json) {
    final items = (json['food_items'] as List<dynamic>? ?? const [])
        .map((e) => e as Map<String, dynamic>)
        .map(
          (f) => FoodItem(
            mealRecordId: '',
            imagePath: f['image_path'] as String,
            name: f['name'] as String,
            comment: f['comment'] as String? ?? '',
            aiRecognized: f['ai_recognized'] as bool? ?? false,
            aiConfidence: (f['ai_confidence'] as num?)?.toDouble(),
          ),
        )
        .toList();
    return MealRecord(
      date: _parseDate(json['date'] as String),
      mealType: _parseMealType(json['meal_type'] as String? ?? ''),
      foodItems: items,
    );
  }

  BodyFeedback _feedbackFromJson(Map<String, dynamic> json) {
    final symptoms = (json['symptoms'] as List<dynamic>? ?? const [])
        .map((e) => e as Map<String, dynamic>)
        .map(
          (s) => GutSymptom(
            feedbackId: '',
            type: SymptomType.values.firstWhere(
              (t) => t.name == s['type'],
              orElse: () => SymptomType.diarrhea,
            ),
            severity: Severity.values.firstWhere(
              (se) => se.name == s['severity'],
              orElse: () => Severity.mild,
            ),
          ),
        )
        .toList();
    return BodyFeedback(
      date: _parseDate(json['date'] as String),
      energyScore: (json['energy_score'] as num?)?.toInt(),
      digestionScore: (json['digestion_score'] as num?)?.toInt(),
      sleepScore: (json['sleep_score'] as num?)?.toInt(),
      stomachScore: (json['stomach_score'] as num?)?.toInt(),
      skinScore: (json['skin_score'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      note: json['note'] as String? ?? '',
      symptoms: symptoms,
    );
  }

  AdviceRecord _adviceFromJson(Map<String, dynamic> json) {
    return AdviceRecord(
      queryText: json['query_text'] as String? ?? '',
      queryImagePath: json['query_image_path'] as String?,
      conclusion: AdviceConclusion.values.firstWhere(
        (c) => c.name == json['conclusion'],
        orElse: () => AdviceConclusion.cautious,
      ),
      reason: json['reason'] as String? ?? '',
      riskFactors: (json['risk_factors'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      createdAt:
          DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }

  DateTime _parseDate(String dateKey) {
    final parts = dateKey.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  MealType _parseMealType(String name) {
    return MealType.values.firstWhere(
      (t) => t.name == name,
      orElse: () => MealType.snack,
    );
  }
}
