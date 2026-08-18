export 'enums.dart';

import 'enums.dart';

class FoodItem {
  FoodItem({
    this.id,
    required this.mealRecordId,
    required this.imagePath,
    required this.name,
    this.comment = '',
    this.aiRecognized = false,
    this.aiConfidence,
  });

  String? id;
  final String mealRecordId;
  final String imagePath;
  final String name;
  final String comment;
  final bool aiRecognized;
  final double? aiConfidence;
}

class MealRecord {
  MealRecord({
    this.id,
    required this.date,
    required this.mealType,
    List<FoodItem>? foodItems,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : foodItems = foodItems ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  String? id;
  final DateTime date;
  final MealType mealType;
  final List<FoodItem> foodItems;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get dateKey => _formatDate(date);
}

class GutSymptom {
  GutSymptom({
    this.id,
    required this.feedbackId,
    required this.type,
    required this.severity,
  });

  String? id;
  final String feedbackId;
  final SymptomType type;
  final Severity severity;
}

class BodyFeedback {
  BodyFeedback({
    this.id,
    required this.date,
    this.energyScore,
    this.digestionScore,
    this.sleepScore,
    this.stomachScore,
    this.skinScore,
    this.weight,
    this.note = '',
    List<GutSymptom>? symptoms,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : symptoms = symptoms ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  String? id;
  final DateTime date;
  final int? energyScore;
  final int? digestionScore;
  final int? sleepScore;
  final int? stomachScore;
  final int? skinScore;
  final double? weight;
  final String note;
  final List<GutSymptom> symptoms;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get dateKey => _formatDate(date);

  bool get hasAnyScore =>
      energyScore != null ||
      digestionScore != null ||
      sleepScore != null ||
      stomachScore != null ||
      skinScore != null ||
      weight != null;
}

class AdviceRecord {
  AdviceRecord({
    this.id,
    required this.queryText,
    required this.conclusion,
    required this.reason,
    this.queryImagePath,
    this.riskFactors = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  String? id;
  final String queryText;
  final String? queryImagePath;
  final AdviceConclusion conclusion;
  final String reason;
  final List<String> riskFactors;
  final DateTime createdAt;
}

String _formatDate(DateTime date) {
  final y = date.year.toString().padLeft(4, '0');
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}
