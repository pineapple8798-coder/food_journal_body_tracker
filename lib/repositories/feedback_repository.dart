import '../models/models.dart';

abstract class FeedbackRepository {
  Future<BodyFeedback> saveFeedback(BodyFeedback feedback);

  Future<BodyFeedback?> getFeedbackByDate(DateTime date);

  Future<void> updateFeedback(BodyFeedback feedback);

  Future<void> deleteFeedback(String id);
}
