import 'package:drift/drift.dart';

import '../data/database.dart' as ddb;
import '../data/db_utils.dart';
import '../models/models.dart';
import 'advice_repository.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  AdviceRepositoryImpl(this.db);

  final ddb.AppDatabase db;

  @override
  Future<AdviceRecord> saveAdvice(AdviceRecord record) async {
    final adviceId = record.id ?? DbUtils.newId();
    await db.into(db.adviceRecords).insert(
          ddb.AdviceRecordsCompanion.insert(
            id: adviceId,
            queryText: record.queryText,
            queryImagePath: Value(record.queryImagePath),
            conclusion: record.conclusion.name,
            reason: record.reason,
            riskFactors: Value(record.riskFactors.join('|')),
            createdAt: record.createdAt,
          ),
        );
    return await _loadAdvice(adviceId) ?? record;
  }

  @override
  Future<List<AdviceRecord>> getAdviceHistory({int limit = 50}) async {
    final rows = await (db.select(db.adviceRecords)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .get();

    final records = <AdviceRecord>[];
    for (final row in rows) {
      final record = _fromRow(row);
      if (record != null) records.add(record);
    }
    return records;
  }

  Future<AdviceRecord?> _loadAdvice(String id) async {
    final row = await (db.select(db.adviceRecords)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  AdviceRecord? _fromRow(ddb.AdviceRecord row) {
    return AdviceRecord(
      id: row.id,
      queryText: row.queryText,
      queryImagePath: row.queryImagePath,
      conclusion: AdviceConclusion.values.firstWhere(
        (c) => c.name == row.conclusion,
        orElse: () => AdviceConclusion.cautious,
      ),
      reason: row.reason,
      riskFactors: row.riskFactors.isEmpty
          ? const []
          : row.riskFactors.split('|'),
      createdAt: row.createdAt,
    );
  }
}
