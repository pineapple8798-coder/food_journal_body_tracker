import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database.dart';
import 'pages/home_page.dart';
import 'providers/app_providers.dart';
import 'services/ai_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('zh_CN');
  final db = await AppDatabase.open();
  final prefs = await SharedPreferences.getInstance();
  final savedConfig = AiConfig.fromStorage(prefs.getString('ai_config'));
  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        sharedPreferencesProvider.overrideWithValue(prefs),
        aiConfigProvider.overrideWith((ref) => savedConfig),
      ],
      child: const FoodJournalApp(),
    ),
  );
}

class FoodJournalApp extends StatelessWidget {
  const FoodJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '美食记录',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
