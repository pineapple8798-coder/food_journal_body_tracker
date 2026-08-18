import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/database.dart';
import '../repositories/advice_repository_impl.dart';
import '../repositories/feedback_repository_impl.dart';
import '../repositories/meal_repository_impl.dart';
import '../services/ai_config.dart';
import '../services/ai_service.dart';
import '../services/backup_service_impl.dart';
import '../services/backup_service.dart';
import '../services/mock_ai_service.dart';
import '../services/openai_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider 需在运行时初始化');
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider 需在运行时初始化');
});

final mealRepositoryProvider = Provider<MealRepositoryImpl>((ref) {
  return MealRepositoryImpl(ref.watch(databaseProvider));
});

final feedbackRepositoryProvider = Provider<FeedbackRepositoryImpl>((ref) {
  return FeedbackRepositoryImpl(ref.watch(databaseProvider));
});

final adviceRepositoryProvider = Provider<AdviceRepositoryImpl>((ref) {
  return AdviceRepositoryImpl(ref.watch(databaseProvider));
});

final aiConfigProvider = StateProvider<AiConfig>((ref) {
  return AiConfig();
});

final aiServiceProvider = Provider<AIService>((ref) {
  final config = ref.watch(aiConfigProvider);
  if (config.isConfigured) {
    return OpenAIService(config: config);
  }
  return MockAIService();
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupServiceImpl(
    mealRepo: ref.watch(mealRepositoryProvider),
    feedbackRepo: ref.watch(feedbackRepositoryProvider),
    adviceRepo: ref.watch(adviceRepositoryProvider),
  );
});
