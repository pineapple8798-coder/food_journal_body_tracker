import 'package:drift/drift.dart';

class MealRecords extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get mealType => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class FoodItems extends Table {
  TextColumn get id => text()();
  TextColumn get mealRecordId => text().references(MealRecords, #id, onDelete: KeyAction.cascade)();
  TextColumn get imagePath => text()();
  TextColumn get name => text()();
  TextColumn get comment => text().withDefault(const Constant(''))();
  BoolColumn get aiRecognized => boolean().withDefault(const Constant(false))();
  RealColumn get aiConfidence => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class BodyFeedbacks extends Table {
  TextColumn get id => text()();
  TextColumn get date => text().unique()();
  IntColumn get energyScore => integer().nullable()();
  IntColumn get digestionScore => integer().nullable()();
  IntColumn get sleepScore => integer().nullable()();
  IntColumn get stomachScore => integer().nullable()();
  IntColumn get skinScore => integer().nullable()();
  RealColumn get weight => real().nullable()();
  TextColumn get note => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class GutSymptoms extends Table {
  TextColumn get id => text()();
  TextColumn get feedbackId => text().references(BodyFeedbacks, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  TextColumn get severity => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class AdviceRecords extends Table {
  TextColumn get id => text()();
  TextColumn get queryText => text()();
  TextColumn get queryImagePath => text().nullable()();
  TextColumn get conclusion => text()();
  TextColumn get reason => text()();
  TextColumn get riskFactors => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
