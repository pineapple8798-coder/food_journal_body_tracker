import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app_database.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  MealRecords,
  FoodItems,
  BodyFeedbacks,
  GutSymptoms,
  AdviceRecords,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.file(File file) : super(NativeDatabase(file));

  @override
  int get schemaVersion => 1;

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'food_journal.db'));
    return AppDatabase(NativeDatabase(file));
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (m) => m.createAll(),
      );
}
