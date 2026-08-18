import 'package:flutter_test/flutter_test.dart';
import 'package:food_journal_body_tracker/models/models.dart';

void main() {
  group('MealType 枚举', () {
    test('fromLabel 能正确转换中文标签', () {
      expect(MealType.fromLabel('早餐'), MealType.breakfast);
      expect(MealType.fromLabel('午餐'), MealType.lunch);
      expect(MealType.fromLabel('晚餐'), MealType.dinner);
      expect(MealType.fromLabel('加餐'), MealType.snack);
    });

    test('fromLabel 对未知标签返回 null', () {
      expect(MealType.fromLabel('夜宵'), isNull);
    });
  });

  group('SymptomType 枚举', () {
    test('fromLabel 能正确转换症状', () {
      expect(SymptomType.fromLabel('腹泻'), SymptomType.diarrhea);
      expect(SymptomType.fromLabel('便秘'), SymptomType.constipation);
      expect(SymptomType.fromLabel('胀气'), SymptomType.bloating);
      expect(SymptomType.fromLabel('腹痛'), SymptomType.abdominalPain);
      expect(SymptomType.fromLabel('反酸'), SymptomType.acidReflux);
      expect(SymptomType.fromLabel('恶心'), SymptomType.nausea);
      expect(SymptomType.fromLabel('食欲不振'), SymptomType.lossOfAppetite);
    });
  });

  group('Severity 枚举', () {
    test('fromLabel 能正确转换严重程度', () {
      expect(Severity.fromLabel('轻度'), Severity.mild);
      expect(Severity.fromLabel('中度'), Severity.moderate);
      expect(Severity.fromLabel('重度'), Severity.severe);
    });
  });

  group('AdviceConclusion 枚举', () {
    test('fromLabel 能正确转换建议结论', () {
      expect(AdviceConclusion.fromLabel('建议食用'), AdviceConclusion.recommended);
      expect(AdviceConclusion.fromLabel('谨慎食用'), AdviceConclusion.cautious);
      expect(AdviceConclusion.fromLabel('不建议食用'), AdviceConclusion.notRecommended);
    });
  });

  group('MealRecord 模型', () {
    test('dateKey 格式为 yyyy-MM-dd', () {
      final meal = MealRecord(
        date: DateTime(2026, 8, 5),
        mealType: MealType.lunch,
      );
      expect(meal.dateKey, '2026-08-05');
    });

    test('dateKey 月份日期补零', () {
      final meal = MealRecord(
        date: DateTime(2026, 1, 3),
        mealType: MealType.breakfast,
      );
      expect(meal.dateKey, '2026-01-03');
    });

    test('foodItems 默认空列表', () {
      final meal = MealRecord(date: DateTime.now(), mealType: MealType.dinner);
      expect(meal.foodItems, isEmpty);
    });
  });

  group('BodyFeedback 模型', () {
    test('dateKey 格式为 yyyy-MM-dd', () {
      final feedback = BodyFeedback(date: DateTime(2026, 12, 31));
      expect(feedback.dateKey, '2026-12-31');
    });

    test('hasAnyScore 当有评分时返回 true', () {
      final feedback = BodyFeedback(
        date: DateTime.now(),
        energyScore: 4,
      );
      expect(feedback.hasAnyScore, isTrue);
    });

    test('hasAnyScore 当有体重时返回 true', () {
      final feedback = BodyFeedback(
        date: DateTime.now(),
        weight: 65.5,
      );
      expect(feedback.hasAnyScore, isTrue);
    });

    test('hasAnyScore 当全部为空时返回 false', () {
      final feedback = BodyFeedback(date: DateTime.now());
      expect(feedback.hasAnyScore, isFalse);
    });

    test('symptoms 默认空列表', () {
      final feedback = BodyFeedback(date: DateTime.now());
      expect(feedback.symptoms, isEmpty);
    });
  });

  group('AdviceRecord 模型', () {
    test('riskFactors 默认空列表', () {
      final advice = AdviceRecord(
        queryText: '火锅',
        conclusion: AdviceConclusion.cautious,
        reason: '高油脂',
      );
      expect(advice.riskFactors, isEmpty);
    });

    test('createdAt 默认当前时间', () {
      final advice = AdviceRecord(
        queryText: '牛奶',
        conclusion: AdviceConclusion.notRecommended,
        reason: '乳糖不耐受',
      );
      expect(advice.createdAt.isAfter(DateTime(2020)), isTrue);
    });
  });
}
