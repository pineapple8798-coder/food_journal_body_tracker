import '../models/models.dart';

class HistorySummaryBuilder {
  HistorySummaryBuilder({
    required this.meals,
    required this.feedbackList,
  });

  final List<MealRecord> meals;
  final List<BodyFeedback> feedbackList;

  String build() {
    final buffer = StringBuffer();
    buffer.writeln('## 近期饮食记录');
    if (meals.isEmpty) {
      buffer.writeln('（暂无记录）');
    }
    for (final meal in meals) {
      final names = meal.foodItems.map((f) => f.name).join('、');
      buffer.writeln('- ${meal.dateKey} ${meal.mealType.label}: $names');
    }

    buffer.writeln();
    buffer.writeln('## 近期身体反馈与肠胃症状');
    if (feedbackList.isEmpty) {
      buffer.writeln('（暂无记录）');
    }
    for (final feedback in feedbackList) {
      final symptoms = feedback.symptoms
          .map((s) => '${s.type.label}(${s.severity.label})')
          .join('、');
      buffer.writeln('- ${feedback.dateKey}: ${_scoresSummary(feedback)}'
          '${symptoms.isNotEmpty ? '，症状: $symptoms' : ''}'
          '${feedback.note.isNotEmpty ? '，备注: ${feedback.note}' : ''}');
    }
    return buffer.toString();
  }

  String _scoresSummary(BodyFeedback feedback) {
    final parts = <String>[
      if (feedback.energyScore != null) '精力${feedback.energyScore}/5',
      if (feedback.digestionScore != null) '消化${feedback.digestionScore}/5',
      if (feedback.sleepScore != null) '睡眠${feedback.sleepScore}/5',
      if (feedback.stomachScore != null) '肠胃${feedback.stomachScore}/5',
      if (feedback.skinScore != null) '皮肤${feedback.skinScore}/5',
      if (feedback.weight != null) '体重${feedback.weight}kg',
    ];
    return parts.isEmpty ? '未评分' : parts.join(', ');
  }
}
