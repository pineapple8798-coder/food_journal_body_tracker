import '../models/models.dart';

class FoodRecognitionResult {
  FoodRecognitionResult({
    required this.name,
    this.confidence,
    this.candidates = const [],
  });

  final String name;
  final double? confidence;
  final List<String> candidates;
}

class DietAdviceResult {
  DietAdviceResult({
    required this.conclusion,
    required this.reason,
    this.riskFactors = const [],
  });

  final AdviceConclusion conclusion;
  final String reason;
  final List<String> riskFactors;
}

abstract class AIService {
  Future<FoodRecognitionResult> recognizeFood({
    required String imagePath,
  });

  Future<DietAdviceResult> getDietAdvice({
    required String query,
    String? imagePath,
    required String historySummary,
  });
}
