import 'dart:convert';

class AiConfig {
  AiConfig({
    this.apiKey = defaultApiKey,
    this.baseUrl = defaultBaseUrl,
    this.model = defaultModel,
    this.visionModel = defaultVisionModel,
  });

  static const String defaultApiKey =
      String.fromEnvironment('USER_LLM_API_KEY', defaultValue: '');
  static const String defaultBaseUrl = String.fromEnvironment(
    'USER_LLM_BASE_URL',
    defaultValue: 'https://api.siliconflow.cn/v1',
  );
  static const String defaultModel = String.fromEnvironment(
    'USER_LLM_MODEL',
    defaultValue: 'deepseek-ai/DeepSeek-V3',
  );
  static const String defaultVisionModel = String.fromEnvironment(
    'USER_LLM_VISION_MODEL',
    defaultValue: 'Qwen/Qwen2.5-VL-72B-Instruct',
  );

  final String apiKey;
  final String baseUrl;
  final String model;
  final String visionModel;

  bool get isConfigured => apiKey.isNotEmpty && baseUrl.isNotEmpty;

  String get effectiveBaseUrl {
    final url = baseUrl.trim();
    if (url.isEmpty) return 'https://api.siliconflow.cn/v1';
    return url.replaceAll(RegExp(r'/+$'), '');
  }

  AiConfig copyWith({
    String? apiKey,
    String? baseUrl,
    String? model,
    String? visionModel,
  }) {
    return AiConfig(
      apiKey: apiKey ?? this.apiKey,
      baseUrl: baseUrl ?? this.baseUrl,
      model: model ?? this.model,
      visionModel: visionModel ?? this.visionModel,
    );
  }

  Map<String, dynamic> toJson() => {
        'api_key': apiKey,
        'base_url': baseUrl,
        'model': model,
        'vision_model': visionModel,
      };

  factory AiConfig.fromJson(Map<String, dynamic> json) {
    return AiConfig(
      apiKey: json['api_key'] as String? ?? '',
      baseUrl: json['base_url'] as String? ?? '',
      model: json['model'] as String? ?? defaultModel,
      visionModel: json['vision_model'] as String? ?? defaultVisionModel,
    );
  }

  static AiConfig fromStorage(String? raw) {
    if (raw == null || raw.isEmpty) return AiConfig();
    try {
      return AiConfig.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return AiConfig();
    }
  }
}
