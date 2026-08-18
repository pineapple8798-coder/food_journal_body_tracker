import '../models/models.dart';

abstract class MealRepository {
  Future<MealRecord> saveMeal(MealRecord record);

  Future<List<MealRecord>> getMealsByDate(DateTime date);

  Future<MealRecord?> getMealById(String id);

  Future<void> updateMeal(MealRecord record);

  Future<void> deleteMeal(String id);
}
