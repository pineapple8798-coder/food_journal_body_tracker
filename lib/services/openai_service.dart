import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/models.dart';
import 'ai_config.dart';
import 'ai_service.dart';

class OpenAIService implements AIService {
  OpenAIService({Dio? dio, AiConfig? config})
      : _dio = dio ?? Dio(),
        _config = config ?? AiConfig();

  final Dio _dio;
  final AiConfig _config;

  static const _requestTimeout = Duration(seconds: 15);

  @override
  Future<FoodRecognitionResult> recognizeFood({
    required String imagePath,
  }) async {
    final imageBase64 = await _readImageAsBase64(imagePath);
    final payload = {
      'model': _config.visionModel,
      'temperature': 0.2,
      'messages': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'text',
              'text': '识别这张图片中的主要食物，只返回食物名称，不要包含其他文字。',
            },
            {
              'type': 'image_url',
              'image_url': {'url': 'data:image/jpeg;base64,$imageBase64'},
            },
          ],
        },
      ],
    };

    final data = await _chatCompletion(payload);
    final name = _extractContent(data).trim();
    if (name.isEmpty) {
      throw Exception('AI 识别未返回食物名称');
    }
    return FoodRecognitionResult(name: name);
  }

  @override
  Future<DietAdviceResult> getDietAdvice({
    required String query,
    String? imagePath,
    required String historySummary,
  }) async {
    final systemPrompt = '''
你是一位肠胃健康饮食顾问。用户有肠胃敏感问题，希望了解某种食物能否食用。
结合用户的历史饮食记录与肠胃症状给出建议。

规则：
1. 结论只能从三档中选择：建议食用 / 谨慎食用 / 不建议食用
2. 必须说明得出该结论的原因，尤其要关联用户的历史肠胃症状
3. 列出可能涉及的肠胃风险因素（如刺激性、高纤维、乳糖等）
4. 历史记录不足时明确提示参考价值有限

用户近期历史记录摘要：
$historySummary

请严格按照以下 JSON 格式输出，不要输出其他内容：
{"conclusion":"结论","reason":"原因说明","risk_factors":["风险因素1","风险因素2"]}
''';

    final userMessage = imagePath != null
        ? [
            {
              'type': 'text',
              'text': query.isEmpty ? '这个食物我能不能吃？' : query,
            },
            {
              'type': 'image_url',
              'image_url': {
                'url':
                    'data:image/jpeg;base64,${await _readImageAsBase64(imagePath)}',
              },
            },
          ]
        : query;

    final payload = {
      'model': _config.model,
      'temperature': 0.3,
      'response_format': {'type': 'json_object'},
      'messages': [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': userMessage},
      ],
    };

    final data = await _chatCompletion(payload);
    return _parseAdviceResult(_extractContent(data));
  }

  Future<Map<String, dynamic>> _chatCompletion(Map<String, dynamic> payload) async {
    final base = _config.effectiveBaseUrl.replaceAll(RegExp(r'/+$'), '');
    final headers = {
      'Authorization': 'Bearer ${_config.apiKey}',
      'Content-Type': 'application/json',
    };
    try {
      final response = await _dio.post(
        '$base/chat/completions',
        data: jsonEncode(payload),
        options: Options(
          headers: headers,
          sendTimeout: _requestTimeout,
          receiveTimeout: _requestTimeout,
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('AI 服务请求失败: HTTP ${response.statusCode} ${response.data}');
      }
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception(_friendlyError(e));
    }
  }

  String _friendlyError(Object error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return 'AI 服务请求超时，请稍后重试';
      }
      if (error.type == DioExceptionType.connectionError) {
        return '无法连接 AI 服务，请检查手机网络或 AI 设置中的 Base URL';
      }
      final statusCode = error.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        return 'API Key 无效或无权限，请在「我的-AI 服务设置」中检查 API Key';
      }
      if (statusCode == 404) {
        return '模型名称不存在，请在 AI 服务设置中检查模型名（需带厂商前缀，如 Qwen/Qwen3-VL-30B-A3B-Instruct）';
      }
      if (statusCode != null) {
        return 'AI 服务返回错误（HTTP $statusCode），请稍后重试';
      }
      return '网络请求异常，请稍后重试';
    }
    return error.toString();
  }

  String _extractContent(Map<String, dynamic> data) {
    final choices = data['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) {
      throw Exception('AI 响应格式异常');
    }
    final content = (choices.first as Map<String, dynamic>)['message']
            ?['content'] as String? ??
        '';
    return content.trim();
  }

  @visibleForTesting
  DietAdviceResult parseAdviceResult(String content) =>
      _parseAdviceResult(content);

  @visibleForTesting
  AdviceConclusion mapConclusion(String text) => _mapConclusion(text);

  DietAdviceResult _parseAdviceResult(String content) {
    try {
      final json = jsonDecode(content) as Map<String, dynamic>;
      final conclusionText = json['conclusion']?.toString() ?? '';
      final reason = json['reason']?.toString() ?? '';
      final riskFactors = (json['risk_factors'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList();

      final conclusion = _mapConclusion(conclusionText);
      return DietAdviceResult(
        conclusion: conclusion,
        reason: reason,
        riskFactors: riskFactors,
      );
    } catch (_) {
      return DietAdviceResult(
        conclusion: AdviceConclusion.cautious,
        reason: 'AI 响应解析失败，请重试',
        riskFactors: const [],
      );
    }
  }

  AdviceConclusion _mapConclusion(String text) {
    if (text.contains('不建议')) return AdviceConclusion.notRecommended;
    if (text.contains('谨慎')) return AdviceConclusion.cautious;
    return AdviceConclusion.recommended;
  }

  Future<String> _readImageAsBase64(String imagePath) async {
    final file = File(imagePath);
    if (!await file.exists()) {
      throw Exception('图片文件不存在: $imagePath');
    }
    return base64Encode(await file.readAsBytes());
  }
}
