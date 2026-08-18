import 'package:flutter_test/flutter_test.dart';
import 'package:food_journal_body_tracker/models/models.dart';
import 'package:food_journal_body_tracker/models/validators.dart';

void main() {
  group('MealValidator.validateScore', () {
    test('1-5 分合法返回 null', () {
      expect(MealValidator.validateScore('精力', 1), isNull);
      expect(MealValidator.validateScore('精力', 3), isNull);
      expect(MealValidator.validateScore('精力', 5), isNull);
    });

    test('null 返回 null（未评分）', () {
      expect(MealValidator.validateScore('精力', null), isNull);
    });

    test('超出 1-5 范围返回错误', () {
      expect(MealValidator.validateScore('精力', 0), isNotNull);
      expect(MealValidator.validateScore('精力', 6), isNotNull);
    });
  });

  group('MealValidator.validateWeight', () {
    test('正数体重合法', () {
      expect(MealValidator.validateWeight(60.0), isNull);
      expect(MealValidator.validateWeight(0.1), isNull);
    });

    test('零或负数体重非法', () {
      expect(MealValidator.validateWeight(0), isNotNull);
      expect(MealValidator.validateWeight(-5), isNotNull);
    });

    test('null 返回 null（未填写）', () {
      expect(MealValidator.validateWeight(null), isNull);
    });
  });

  group('MealValidator.validateMeal', () {
    test('空食物条目报错', () {
      final meal = MealRecord(date: DateTime.now(), mealType: MealType.lunch);
      expect(MealValidator.validateMeal(meal), isNotNull);
    });

    test('食物名称为空报错', () {
      final meal = MealRecord(
        date: DateTime.now(),
        mealType: MealType.lunch,
        foodItems: [
          FoodItem(
            mealRecordId: 'meal1',
            imagePath: '/tmp/a.jpg',
            name: '  ',
          ),
        ],
      );
      expect(MealValidator.validateMeal(meal), isNotNull);
    });

    test('图片路径为空报错', () {
      final meal = MealRecord(
        date: DateTime.now(),
        mealType: MealType.lunch,
        foodItems: [
          FoodItem(
            mealRecordId: 'meal1',
            imagePath: '',
            name: '红烧肉',
          ),
        ],
      );
      expect(MealValidator.validateMeal(meal), isNotNull);
    });

    test('合法餐次返回 null', () {
      final meal = MealRecord(
        date: DateTime.now(),
        mealType: MealType.lunch,
        foodItems: [
          FoodItem(
            mealRecordId: 'meal1',
            imagePath: '/tmp/a.jpg',
            name: '红烧肉',
          ),
        ],
      );
      expect(MealValidator.validateMeal(meal), isNull);
    });
  });

  group('MealValidator.validateFeedback', () {
    test('全部为空且无症状报错', () {
      final feedback = BodyFeedback(date: DateTime.now());
      expect(MealValidator.validateFeedback(feedback), isNotNull);
    });

    test('至少一项评分通过', () {
      final feedback = BodyFeedback(
        date: DateTime.now(),
        energyScore: 4,
      );
      expect(MealValidator.validateFeedback(feedback), isNull);
    });

    test('仅体重通过', () {
      final feedback = BodyFeedback(
        date: DateTime.now(),
        weight: 65.0,
      );
      expect(MealValidator.validateFeedback(feedback), isNull);
    });

    test('仅症状通过', () {
      final feedback = BodyFeedback(
        date: DateTime.now(),
        symptoms: [
          GutSymptom(
            feedbackId: 'f1',
            type: SymptomType.diarrhea,
            severity: Severity.mild,
          ),
        ],
      );
      expect(MealValidator.validateFeedback(feedback), isNull);
    });

    test('评分超界报错', () {
      final feedback = BodyFeedback(
        date: DateTime.now(),
        sleepScore: 7,
      );
      expect(MealValidator.validateFeedback(feedback), isNotNull);
    });

    test('体重为负报错', () {
      final feedback = BodyFeedback(
        date: DateTime.now(),
        weight: -3,
      );
      expect(MealValidator.validateFeedback(feedback), isNotNull);
    });
  });
}
