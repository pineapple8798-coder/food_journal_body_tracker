enum MealType {
  breakfast('早餐'),
  lunch('午餐'),
  dinner('晚餐'),
  snack('加餐');

  const MealType(this.label);

  final String label;

  static MealType? fromLabel(String label) {
    for (final type in MealType.values) {
      if (type.label == label) return type;
    }
    return null;
  }
}

enum SymptomType {
  diarrhea('腹泻'),
  constipation('便秘'),
  bloating('胀气'),
  abdominalPain('腹痛'),
  acidReflux('反酸'),
  nausea('恶心'),
  lossOfAppetite('食欲不振');

  const SymptomType(this.label);

  final String label;

  static SymptomType? fromLabel(String label) {
    for (final type in SymptomType.values) {
      if (type.label == label) return type;
    }
    return null;
  }
}

enum Severity {
  mild('轻度'),
  moderate('中度'),
  severe('重度');

  const Severity(this.label);

  final String label;

  static Severity? fromLabel(String label) {
    for (final severity in Severity.values) {
      if (severity.label == label) return severity;
    }
    return null;
  }
}

enum AdviceConclusion {
  recommended('建议食用'),
  cautious('谨慎食用'),
  notRecommended('不建议食用');

  const AdviceConclusion(this.label);

  final String label;

  static AdviceConclusion? fromLabel(String label) {
    for (final conclusion in AdviceConclusion.values) {
      if (conclusion.label == label) return conclusion;
    }
    return null;
  }
}
