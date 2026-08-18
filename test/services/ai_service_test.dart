import 'package:flutter_test/flutter_test.dart';
import 'package:food_journal_body_tracker/models/models.dart';
import 'package:food_journal_body_tracker/services/history_summary_builder.dart';
import 'package:food_journal_body_tracker/services/mock_ai_service.dart';
import 'package:food_journal_body_tracker/services/openai_service.dart';

void main() {
  group('MockAIService', () {
    test('recognizeFood 返回配置的食物名称', () async {
      final service = MockAIService(foodName: '宫保鸡丁');
      final result = await service.recognizeFood(imagePath: '/tmp/a.jpg');
      expect(result.name, '宫保鸡丁');
      expect(result.confidence, 0.95);
    });

    test('recognizeFood 失败分支抛出异常', () async {
      final service = MockAIService(shouldFail: true);
      expect(
        () => service.recognizeFood(imagePath: '/tmp/a.jpg'),
        throwsException,
      );
    });

    test('getDietAdvice 返回配置结论', () async {
      final service = MockAIService(
        adviceConclusion: AdviceConclusion.notRecommended,
        adviceReason: '乳糖不耐受',
        riskFactors: ['乳糖'],
      );
      final result = await service.getDietAdvice(
        query: '牛奶',
        historySummary: '近30天记录',
      );
      expect(result.conclusion, AdviceConclusion.notRecommended);
      expect(result.riskFactors, ['乳糖']);
    });

    test('getDietAdvice 失败分支抛出异常', () async {
      final service = MockAIService(shouldFail: true);
      expect(
        () => service.getDietAdvice(
          query: '牛奶',
          historySummary: '记录',
        ),
        throwsException,
      );
    });
  });

  group('OpenAIService 解析逻辑', () {
    final service = OpenAIService();

    test('mapConclusion 正确映射三档结论', () {
      expect(service.mapConclusion('不建议食用'), AdviceConclusion.notRecommended);
      expect(service.mapConclusion('谨慎食用'), AdviceConclusion.cautious);
      expect(service.mapConclusion('建议食用'), AdviceConclusion.recommended);
      expect(service.mapConclusion('不建议'), AdviceConclusion.notRecommended);
      expect(service.mapConclusion('谨慎'), AdviceConclusion.cautious);
      expect(service.mapConclusion('其他'), AdviceConclusion.recommended);
    });

    test('parseAdviceResult 解析合法 JSON', () {
      final result = service.parseAdviceResult(
        '{"conclusion":"谨慎食用","reason":"该食物曾引发腹胀","risk_factors":["高纤维","乳糖"]}',
      );
      expect(result.conclusion, AdviceConclusion.cautious);
      expect(result.reason, '该食物曾引发腹胀');
      expect(result.riskFactors, ['高纤维', '乳糖']);
    });

    test('parseAdviceResult 处理非法 JSON 返回兜底结论', () {
      final result = service.parseAdviceResult('不是 JSON');
      expect(result.conclusion, AdviceConclusion.cautious);
      expect(result.reason, isNotEmpty);
    });

    test('parseAdviceResult 缺字段时使用默认值', () {
      final result = service.parseAdviceResult('{"conclusion":"建议食用"}');
      expect(result.conclusion, AdviceConclusion.recommended);
      expect(result.reason, '');
      expect(result.riskFactors, isEmpty);
    });
  });

  group('HistorySummaryBuilder', () {
    test('空数据生成占位内容', () {
      final builder = HistorySummaryBuilder(meals: [], feedbackList: []);
      final summary = builder.build();
      expect(summary, contains('暂无记录'));
    });

    test('包含饮食记录与症状信息', () {
      final meal = MealRecord(
        date: DateTime(2026, 8, 17),
        mealType: MealType.lunch,
        foodItems: [
          FoodItem(
            mealRecordId: 'm1',
            imagePath: '/img/a.jpg',
            name: '红烧肉',
          ),
        ],
      );
      final feedback = BodyFeedback(
        date: DateTime(2026, 8, 17),
        energyScore: 3,
        symptoms: [
          GutSymptom(
            feedbackId: 'f1',
            type: SymptomType.bloating,
            severity: Severity.moderate,
          ),
        ],
        note: '下午腹胀',
      );

      final builder = HistorySummaryBuilder(
        meals: [meal],
        feedbackList: [feedback],
      );
      final summary = builder.build();

      expect(summary, contains('2026-08-17'));
      expect(summary, contains('午餐'));
      expect(summary, contains('红烧肉'));
      expect(summary, contains('精力3/5'));
      expect(summary, contains('胀气(中度)'));
      expect(summary, contains('下午腹胀'));
    });

    test('体重记录包含在摘要中', () {
      final feedback = BodyFeedback(
        date: DateTime(2026, 8, 17),
        weight: 65.5,
      );
      final builder = HistorySummaryBuilder(
        meals: [],
        feedbackList: [feedback],
      );
      final summary = builder.build();
      expect(summary, contains('体重65.5kg'));
    });

    test('未评分反馈显示占位', () {
      final feedback = BodyFeedback(date: DateTime(2026, 8, 17));
      final builder = HistorySummaryBuilder(
        meals: [],
        feedbackList: [feedback],
      );
      final summary = builder.build();
      expect(summary, contains('未评分'));
    });
  });
}
