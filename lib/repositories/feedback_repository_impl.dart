import 'package:drift/drift.dart';

import '../data/database.dart' as ddb;
import '../data/db_utils.dart';
import '../models/models.dart';
import 'feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  FeedbackRepositoryImpl(this.db);

  final ddb.AppDatabase db;

  @override
  Future<BodyFeedback> saveFeedback(BodyFeedback feedback) async {
    final feedbackId = feedback.id ?? DbUtils.newId();
    await db.transaction(() async {
      await db.into(db.bodyFeedbacks).insert(
            ddb.BodyFeedbacksCompanion.insert(
              id: feedbackId,
              date: feedback.dateKey,
              energyScore: Value(feedback.energyScore),
              digestionScore: Value(feedback.digestionScore),
              sleepScore: Value(feedback.sleepScore),
              stomachScore: Value(feedback.stomachScore),
              skinScore: Value(feedback.skinScore),
              weight: Value(feedback.weight),
              note: Value(feedback.note),
              createdAt: feedback.createdAt,
              updatedAt: feedback.updatedAt,
            ),
            onConflict: DoUpdate(
              (old) => ddb.BodyFeedbacksCompanion(
                energyScore: Value(feedback.energyScore),
                digestionScore: Value(feedback.digestionScore),
                sleepScore: Value(feedback.sleepScore),
                stomachScore: Value(feedback.stomachScore),
                skinScore: Value(feedback.skinScore),
                weight: Value(feedback.weight),
                note: Value(feedback.note),
                updatedAt: Value(DateTime.now()),
              ),
              target: [db.bodyFeedbacks.date],
            ),
          );

      await (db.delete(db.gutSymptoms)..where((t) => t.feedbackId.equals(feedbackId))).go();
      for (final symptom in feedback.symptoms) {
        await db.into(db.gutSymptoms).insert(
              ddb.GutSymptomsCompanion.insert(
                id: DbUtils.newId(),
                feedbackId: feedbackId,
                type: symptom.type.name,
                severity: symptom.severity.name,
              ),
            );
      }
    });
    return await _loadFeedback(feedbackId) ?? feedback;
  }

  @override
  Future<BodyFeedback?> getFeedbackByDate(DateTime date) async {
    final dateKey = DbUtils.formatDateKey(date);
    final row = await (db.select(db.bodyFeedbacks)..where((t) => t.date.equals(dateKey)))
        .getSingleOrNull();
    if (row == null) return null;
    return _loadFeedback(row.id);
  }

  @override
  Future<void> updateFeedback(BodyFeedback feedback) async {
    if (feedback.id == null) {
      await saveFeedback(feedback);
      return;
    }
    await db.transaction(() async {
      await (db.update(db.bodyFeedbacks)..where((t) => t.id.equals(feedback.id!)))
          .write(
            ddb.BodyFeedbacksCompanion(
              date: Value(feedback.dateKey),
              energyScore: Value(feedback.energyScore),
              digestionScore: Value(feedback.digestionScore),
              sleepScore: Value(feedback.sleepScore),
              stomachScore: Value(feedback.stomachScore),
              skinScore: Value(feedback.skinScore),
              weight: Value(feedback.weight),
              note: Value(feedback.note),
              updatedAt: Value(DateTime.now()),
            ),
          );

      await (db.delete(db.gutSymptoms)..where((t) => t.feedbackId.equals(feedback.id!))).go();
      for (final symptom in feedback.symptoms) {
        await db.into(db.gutSymptoms).insert(
              ddb.GutSymptomsCompanion.insert(
                id: DbUtils.newId(),
                feedbackId: feedback.id!,
                type: symptom.type.name,
                severity: symptom.severity.name,
              ),
            );
      }
    });
  }

  @override
  Future<void> deleteFeedback(String id) async {
    await db.transaction(() async {
      await (db.delete(db.gutSymptoms)..where((t) => t.feedbackId.equals(id)))
          .go();
      await (db.delete(db.bodyFeedbacks)..where((t) => t.id.equals(id))).go();
    });
  }

  Future<BodyFeedback?> _loadFeedback(String id) async {
    final row = await (db.select(db.bodyFeedbacks)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;

    final symptomRows = await (db.select(db.gutSymptoms)
          ..where((t) => t.feedbackId.equals(id)))
        .get();

    final dateParts = row.date.split('-');
    final symptoms = symptomRows.map((r) {
      return GutSymptom(
        id: r.id,
        feedbackId: r.feedbackId,
        type: SymptomType.values.firstWhere(
          (t) => t.name == r.type,
          orElse: () => SymptomType.diarrhea,
        ),
        severity: Severity.values.firstWhere(
          (s) => s.name == r.severity,
          orElse: () => Severity.mild,
        ),
      );
    }).toList();

    return BodyFeedback(
      id: row.id,
      date: DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      ),
      energyScore: row.energyScore,
      digestionScore: row.digestionScore,
      sleepScore: row.sleepScore,
      stomachScore: row.stomachScore,
      skinScore: row.skinScore,
      weight: row.weight,
      note: row.note,
      symptoms: symptoms,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
