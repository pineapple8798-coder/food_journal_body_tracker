import 'models.dart';

class ValidationError implements Exception {
  ValidationError(this.message);

  final String message;

  @override
  String toString() => message;
}

class MealValidator {
  static const int minScore = 1;
  static const int maxScore = 5;

  static String? validateScore(String label, int? value) {
    if (value == null) return null;
    if (value < minScore || value > maxScore) {
      return '$label 评分需在 $minScore-$maxScore 之间';
    }
    return null;
  }

  static String? validateWeight(double? weight) {
    if (weight == null) return null;
    if (weight <= 0) return '体重需大于 0';
    return null;
  }

  static String? validateDate(DateTime date) {
    if (date.isBefore(DateTime(2000))) return '日期不合法';
    return null;
  }

  static String? validateMeal(MealRecord meal) {
    if (meal.dateKey.isEmpty) return '日期不能为空';
    final dateError = validateDate(meal.date);
    if (dateError != null) return dateError;
    if (meal.foodItems.isEmpty) return '一餐至少需要一个食物条目';
    for (final item in meal.foodItems) {
      if (item.name.trim().isEmpty) return '食物名称不能为空';
      if (item.imagePath.trim().isEmpty) return '食物图片不能为空';
    }
    return null;
  }

  static String? validateFeedback(BodyFeedback feedback) {
    if (feedback.dateKey.isEmpty) return '日期不能为空';
    final dateError = validateDate(feedback.date);
    if (dateError != null) return dateError;
    final scoreErrors = [
      validateScore('精力', feedback.energyScore),
      validateScore('消化', feedback.digestionScore),
      validateScore('睡眠', feedback.sleepScore),
      validateScore('肠胃', feedback.stomachScore),
      validateScore('皮肤', feedback.skinScore),
    ].whereType<String>().toList();
    if (scoreErrors.isNotEmpty) return scoreErrors.first;
    final weightError = validateWeight(feedback.weight);
    if (weightError != null) return weightError;
    if (!feedback.hasAnyScore && feedback.symptoms.isEmpty) {
      return '至少需填写一项评分、体重或肠胃症状';
    }
    return null;
  }
}
