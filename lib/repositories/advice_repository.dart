import '../models/models.dart';

abstract class AdviceRepository {
  Future<AdviceRecord> saveAdvice(AdviceRecord record);

  Future<List<AdviceRecord>> getAdviceHistory({int limit = 50});
}
