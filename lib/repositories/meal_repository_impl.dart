import 'package:drift/drift.dart';

import '../data/database.dart' as ddb;
import '../data/db_utils.dart';
import '../models/models.dart';
import 'meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  MealRepositoryImpl(this.db);

  final ddb.AppDatabase db;

  @override
  Future<MealRecord> saveMeal(MealRecord record) async {
    final mealId = record.id ?? DbUtils.newId();
    await db.transaction(() async {
      await db.into(db.mealRecords).insert(
            ddb.MealRecordsCompanion.insert(
              id: mealId,
              date: record.dateKey,
              mealType: record.mealType.name,
              createdAt: record.createdAt,
              updatedAt: record.updatedAt,
            ),
            onConflict: DoUpdate(
              (old) => ddb.MealRecordsCompanion(
                date: Value(record.dateKey),
                mealType: Value(record.mealType.name),
                updatedAt: Value(DateTime.now()),
              ),
              target: [db.mealRecords.id],
            ),
          );

      for (final item in record.foodItems) {
        final itemId = item.id ?? DbUtils.newId();
        await db.into(db.foodItems).insert(
              ddb.FoodItemsCompanion.insert(
                id: itemId,
                mealRecordId: mealId,
                imagePath: item.imagePath,
                name: item.name,
                comment: Value(item.comment),
                aiRecognized: Value(item.aiRecognized),
                aiConfidence: Value(item.aiConfidence),
                createdAt: DateTime.now(),
              ),
            );
      }
    });
    return await _loadMeal(mealId) ?? record;
  }

  @override
  Future<List<MealRecord>> getMealsByDate(DateTime date) async {
    final dateKey = DbUtils.formatDateKey(date);
    final mealRows = await (db.select(db.mealRecords)
          ..where((t) => t.date.equals(dateKey))
          ..orderBy([
            (t) => OrderingTerm(expression: t.mealType, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc),
          ]))
        .get();

    final records = <MealRecord>[];
    for (final row in mealRows) {
      final record = await _loadMeal(row.id);
      if (record != null) records.add(record);
    }
    return records;
  }

  @override
  Future<MealRecord?> getMealById(String id) => _loadMeal(id);

  @override
  Future<void> updateMeal(MealRecord record) async {
    if (record.id == null) {
      await saveMeal(record);
      return;
    }
    await db.transaction(() async {
      await (db.update(db.mealRecords)..where((t) => t.id.equals(record.id!)))
          .write(
            ddb.MealRecordsCompanion(
              date: Value(record.dateKey),
              mealType: Value(record.mealType.name),
              updatedAt: Value(DateTime.now()),
            ),
          );

      final existingItemIds = await _getItemIds(record.id!);
      final newItemIds = record.foodItems.map((f) => f.id).whereType<String>().toSet();
      final toDelete = existingItemIds.where((id) => !newItemIds.contains(id));
      for (final id in toDelete) {
        await (db.delete(db.foodItems)..where((t) => t.id.equals(id))).go();
      }

      for (final item in record.foodItems) {
        final itemId = item.id ?? DbUtils.newId();
        await db.into(db.foodItems).insert(
              ddb.FoodItemsCompanion.insert(
                id: itemId,
                mealRecordId: record.id!,
                imagePath: item.imagePath,
                name: item.name,
                comment: Value(item.comment),
                aiRecognized: Value(item.aiRecognized),
                aiConfidence: Value(item.aiConfidence),
                createdAt: DateTime.now(),
              ),
              onConflict: DoUpdate(
                (old) => ddb.FoodItemsCompanion(
                  imagePath: Value(item.imagePath),
                  name: Value(item.name),
                  comment: Value(item.comment),
                  aiRecognized: Value(item.aiRecognized),
                  aiConfidence: Value(item.aiConfidence),
                ),
                target: [db.foodItems.id],
              ),
            );
      }
    });
  }

  @override
  Future<void> deleteMeal(String id) async {
    await db.transaction(() async {
      await (db.delete(db.foodItems)..where((t) => t.mealRecordId.equals(id))).go();
      await (db.delete(db.mealRecords)..where((t) => t.id.equals(id))).go();
    });
  }

  Future<MealRecord?> _loadMeal(String id) async {
    final row = await (db.select(db.mealRecords)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;

    final itemRows = await (db.select(db.foodItems)
          ..where((t) => t.mealRecordId.equals(id)))
        .get();

    final dateParts = row.date.split('-');
    final items = itemRows.map((r) {
      return FoodItem(
        id: r.id,
        mealRecordId: r.mealRecordId,
        imagePath: r.imagePath,
        name: r.name,
        comment: r.comment,
        aiRecognized: r.aiRecognized,
        aiConfidence: r.aiConfidence,
      );
    }).toList();

    return MealRecord(
      id: row.id,
      date: DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      ),
      mealType: MealType.values.firstWhere(
        (t) => t.name == row.mealType,
        orElse: () => MealType.snack,
      ),
      foodItems: items,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Future<List<String>> _getItemIds(String mealRecordId) async {
    final rows = await (db.select(db.foodItems)
          ..where((t) => t.mealRecordId.equals(mealRecordId)))
        .get();
    return rows.map((r) => r.id).toList();
  }
}
