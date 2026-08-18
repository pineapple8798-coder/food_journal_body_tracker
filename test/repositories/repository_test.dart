import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_journal_body_tracker/data/database.dart' as ddb;
import 'package:food_journal_body_tracker/models/models.dart';
import 'package:food_journal_body_tracker/repositories/advice_repository_impl.dart';
import 'package:food_journal_body_tracker/repositories/feedback_repository_impl.dart';
import 'package:food_journal_body_tracker/repositories/meal_repository_impl.dart';

void main() {
  late ddb.AppDatabase db;
  late MealRepositoryImpl mealRepo;
  late FeedbackRepositoryImpl feedbackRepo;
  late AdviceRepositoryImpl adviceRepo;

  setUp(() async {
    db = ddb.AppDatabase(NativeDatabase.memory());
    mealRepo = MealRepositoryImpl(db);
    feedbackRepo = FeedbackRepositoryImpl(db);
    adviceRepo = AdviceRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('MealRepository', () {
    test('saveMeal 保存并返回带 ID 的记录', () async {
      final meal = MealRecord(
        date: DateTime(2026, 8, 17),
        mealType: MealType.lunch,
        foodItems: [
          FoodItem(
            mealRecordId: '',
            imagePath: '/img/a.jpg',
            name: '红烧肉',
            comment: '好吃',
          ),
        ],
      );

      final saved = await mealRepo.saveMeal(meal);
      expect(saved.id, isNotNull);
      expect(saved.foodItems.length, 1);
      expect(saved.foodItems.first.id, isNotNull);
      expect(saved.foodItems.first.mealRecordId, saved.id);
    });

    test('getMealsByDate 按日期过滤', () async {
      final meal1 = MealRecord(
        date: DateTime(2026, 8, 17),
        mealType: MealType.breakfast,
        foodItems: [
          FoodItem(
            mealRecordId: '',
            imagePath: '/img/b.jpg',
            name: '包子',
          ),
        ],
      );
      final meal2 = MealRecord(
        date: DateTime(2026, 8, 16),
        mealType: MealType.dinner,
        foodItems: [
          FoodItem(
            mealRecordId: '',
            imagePath: '/img/c.jpg',
            name: '米饭',
          ),
        ],
      );

      await mealRepo.saveMeal(meal1);
      await mealRepo.saveMeal(meal2);

      final on17th = await mealRepo.getMealsByDate(DateTime(2026, 8, 17));
      expect(on17th.length, 1);
      expect(on17th.first.mealType, MealType.breakfast);

      final on16th = await mealRepo.getMealsByDate(DateTime(2026, 8, 16));
      expect(on16th.length, 1);
      expect(on16th.first.mealType, MealType.dinner);
    });

    test('同一日期多餐按餐次返回', () async {
      for (final type in [MealType.breakfast, MealType.lunch, MealType.dinner]) {
        await mealRepo.saveMeal(
          MealRecord(
            date: DateTime(2026, 8, 17),
            mealType: type,
            foodItems: [
              FoodItem(
                mealRecordId: '',
                imagePath: '/img/x.jpg',
                name: type.label,
              ),
            ],
          ),
        );
      }

      final meals = await mealRepo.getMealsByDate(DateTime(2026, 8, 17));
      expect(meals.length, 3);
      expect(meals.map((m) => m.mealType).toSet(),
          {MealType.breakfast, MealType.lunch, MealType.dinner});
    });

    test('一餐多食物条目保存与读取', () async {
      final meal = MealRecord(
        date: DateTime(2026, 8, 17),
        mealType: MealType.lunch,
        foodItems: [
          FoodItem(
            mealRecordId: '',
            imagePath: '/img/1.jpg',
            name: '鱼',
          ),
          FoodItem(
            mealRecordId: '',
            imagePath: '/img/2.jpg',
            name: '蔬菜',
          ),
          FoodItem(
            mealRecordId: '',
            imagePath: '/img/3.jpg',
            name: '汤',
          ),
        ],
      );

      final saved = await mealRepo.saveMeal(meal);
      final loaded = await mealRepo.getMealById(saved.id!);
      expect(loaded, isNotNull);
      expect(loaded!.foodItems.length, 3);
      expect(loaded.foodItems.map((f) => f.name).toSet(),
          {'鱼', '蔬菜', '汤'});
    });

    test('updateMeal 更新餐次与食物条目', () async {
      final saved = await mealRepo.saveMeal(
        MealRecord(
          date: DateTime(2026, 8, 17),
          mealType: MealType.lunch,
          foodItems: [
            FoodItem(
              mealRecordId: '',
              imagePath: '/img/1.jpg',
              name: '鱼',
            ),
          ],
        ),
      );

      await mealRepo.updateMeal(
        MealRecord(
          id: saved.id,
          date: DateTime(2026, 8, 18),
          mealType: MealType.dinner,
          foodItems: saved.foodItems,
        ),
      );

      final loaded = await mealRepo.getMealById(saved.id!);
      expect(loaded, isNotNull);
      expect(loaded!.dateKey, '2026-08-18');
      expect(loaded.mealType, MealType.dinner);
    });

    test('deleteMeal 删除记录', () async {
      final saved = await mealRepo.saveMeal(
        MealRecord(
          date: DateTime(2026, 8, 17),
          mealType: MealType.lunch,
          foodItems: [
            FoodItem(
              mealRecordId: '',
              imagePath: '/img/1.jpg',
              name: '鱼',
            ),
          ],
        ),
      );

      await mealRepo.deleteMeal(saved.id!);
      final loaded = await mealRepo.getMealById(saved.id!);
      expect(loaded, isNull);
    });

    test('deleteMeal 级联删除食物条目', () async {
      final saved = await mealRepo.saveMeal(
        MealRecord(
          date: DateTime(2026, 8, 17),
          mealType: MealType.lunch,
          foodItems: [
            FoodItem(
              mealRecordId: '',
              imagePath: '/img/1.jpg',
              name: '鱼',
            ),
          ],
        ),
      );

      await mealRepo.deleteMeal(saved.id!);
      final allItems = await db.select(db.foodItems).get();
      expect(allItems, isEmpty);
    });
  });

  group('FeedbackRepository', () {
    test('saveFeedback 保存评分与体重', () async {
      final feedback = BodyFeedback(
        date: DateTime(2026, 8, 17),
        energyScore: 4,
        digestionScore: 3,
        weight: 65.5,
        note: '今天状态不错',
      );

      final saved = await feedbackRepo.saveFeedback(feedback);
      expect(saved.id, isNotNull);
      expect(saved.energyScore, 4);
      expect(saved.weight, 65.5);
    });

    test('getFeedbackByDate 按日期查询', () async {
      await feedbackRepo.saveFeedback(
        BodyFeedback(date: DateTime(2026, 8, 17), energyScore: 5),
      );

      final found = await feedbackRepo.getFeedbackByDate(DateTime(2026, 8, 17));
      expect(found, isNotNull);
      expect(found!.energyScore, 5);

      final notFound = await feedbackRepo.getFeedbackByDate(DateTime(2026, 8, 16));
      expect(notFound, isNull);
    });

    test('同一日期重复保存为更新（单日唯一）', () async {
      await feedbackRepo.saveFeedback(
        BodyFeedback(date: DateTime(2026, 8, 17), energyScore: 2),
      );
      await feedbackRepo.saveFeedback(
        BodyFeedback(date: DateTime(2026, 8, 17), energyScore: 5),
      );

      final all = await db.select(db.bodyFeedbacks).get();
      expect(all.length, 1);
      expect(all.first.energyScore, 5);
    });

    test('肠胃症状保存与读取', () async {
      final feedback = BodyFeedback(
        date: DateTime(2026, 8, 17),
        symptoms: [
          GutSymptom(
            feedbackId: '',
            type: SymptomType.diarrhea,
            severity: Severity.mild,
          ),
          GutSymptom(
            feedbackId: '',
            type: SymptomType.bloating,
            severity: Severity.moderate,
          ),
        ],
      );

      final saved = await feedbackRepo.saveFeedback(feedback);
      expect(saved.symptoms.length, 2);

      final loaded = await feedbackRepo.getFeedbackByDate(DateTime(2026, 8, 17));
      expect(loaded, isNotNull);
      expect(loaded!.symptoms.length, 2);
      expect(loaded.symptoms.any((s) => s.type == SymptomType.diarrhea), isTrue);
      expect(loaded.symptoms.any((s) => s.severity == Severity.moderate), isTrue);
    });

    test('updateFeedback 更新症状', () async {
      final saved = await feedbackRepo.saveFeedback(
        BodyFeedback(
          date: DateTime(2026, 8, 17),
          symptoms: [
            GutSymptom(
              feedbackId: '',
              type: SymptomType.nausea,
              severity: Severity.mild,
            ),
          ],
        ),
      );

      await feedbackRepo.updateFeedback(
        BodyFeedback(
          id: saved.id,
          date: DateTime(2026, 8, 17),
          note: '更新后的备注',
          symptoms: [
            GutSymptom(
              feedbackId: saved.id!,
              type: SymptomType.abdominalPain,
              severity: Severity.severe,
            ),
          ],
        ),
      );

      final loaded = await feedbackRepo.getFeedbackByDate(DateTime(2026, 8, 17));
      expect(loaded, isNotNull);
      expect(loaded!.note, '更新后的备注');
      expect(loaded.symptoms.length, 1);
      expect(loaded.symptoms.first.type, SymptomType.abdominalPain);
      expect(loaded.symptoms.first.severity, Severity.severe);
    });

    test('deleteFeedback 删除反馈记录并级联删除症状', () async {
      final saved = await feedbackRepo.saveFeedback(
        BodyFeedback(
          date: DateTime(2026, 8, 17),
          symptoms: [
            GutSymptom(
              feedbackId: '',
              type: SymptomType.nausea,
              severity: Severity.mild,
            ),
          ],
        ),
      );

      await feedbackRepo.deleteFeedback(saved.id!);

      final feedback = await feedbackRepo.getFeedbackByDate(DateTime(2026, 8, 17));
      expect(feedback, isNull);

      final allSymptoms = await db.select(db.gutSymptoms).get();
      expect(allSymptoms, isEmpty);
    });
  });

  group('AdviceRepository', () {
    test('saveAdvice 保存并返回带 ID 记录', () async {
      final advice = AdviceRecord(
        queryText: '火锅我能吃吗',
        conclusion: AdviceConclusion.cautious,
        reason: '高油脂易刺激肠胃',
        riskFactors: ['高油脂', '辛辣'],
      );

      final saved = await adviceRepo.saveAdvice(advice);
      expect(saved.id, isNotNull);
      expect(saved.conclusion, AdviceConclusion.cautious);
    });

    test('getAdviceHistory 按时间倒序返回', () async {
      await adviceRepo.saveAdvice(
        AdviceRecord(
          queryText: '牛奶',
          conclusion: AdviceConclusion.notRecommended,
          reason: '乳糖不耐受',
          createdAt: DateTime(2026, 8, 17, 8, 0),
        ),
      );

      await adviceRepo.saveAdvice(
        AdviceRecord(
          queryText: '苹果',
          conclusion: AdviceConclusion.recommended,
          reason: '温和易消化',
          createdAt: DateTime(2026, 8, 17, 12, 0),
        ),
      );

      final history = await adviceRepo.getAdviceHistory();
      expect(history.length, 2);
      expect(history.first.queryText, '苹果');
      expect(history.last.queryText, '牛奶');
    });

    test('riskFactors 序列化往返一致', () async {
      final saved = await adviceRepo.saveAdvice(
        AdviceRecord(
          queryText: '披萨',
          conclusion: AdviceConclusion.cautious,
          reason: '含乳制品',
          riskFactors: ['乳糖', '高油脂', '高盐'],
        ),
      );

      final history = await adviceRepo.getAdviceHistory();
      expect(history.first.riskFactors, ['乳糖', '高油脂', '高盐']);
      expect(history.first.id, saved.id);
    });

    test('limit 限制返回数量', () async {
      for (var i = 0; i < 5; i++) {
        await adviceRepo.saveAdvice(
          AdviceRecord(
            queryText: '食物$i',
            conclusion: AdviceConclusion.recommended,
            reason: 'ok',
          ),
        );
      }

      final limited = await adviceRepo.getAdviceHistory(limit: 3);
      expect(limited.length, 3);
    });
  });
}
