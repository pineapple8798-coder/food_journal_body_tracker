import '../models/models.dart';
import 'ai_service.dart';

class MockAIService implements AIService {
  MockAIService({
    this.foodName = '红烧肉',
    this.adviceConclusion = AdviceConclusion.cautious,
    this.adviceReason = '示例原因：建议先少量尝试，观察肠胃反应',
    this.riskFactors = const ['高油脂'],
    this.shouldFail = false,
  });

  final String foodName;
  final AdviceConclusion adviceConclusion;
  final String adviceReason;
  final List<String> riskFactors;
  final bool shouldFail;

  @override
  Future<FoodRecognitionResult> recognizeFood({
    required String imagePath,
  }) async {
    if (shouldFail) {
      throw Exception('Mock AI 识别失败');
    }
    return FoodRecognitionResult(
      name: foodName,
      confidence: 0.95,
      candidates: [foodName],
    );
  }

  @override
  Future<DietAdviceResult> getDietAdvice({
    required String query,
    String? imagePath,
    required String historySummary,
  }) async {
    if (shouldFail) {
      throw Exception('Mock AI 建议失败');
    }
    return DietAdviceResult(
      conclusion: adviceConclusion,
      reason: adviceReason,
      riskFactors: riskFactors,
    );
  }
}
