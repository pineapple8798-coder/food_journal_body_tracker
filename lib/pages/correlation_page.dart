import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';

class CorrelationPage extends ConsumerStatefulWidget {
  const CorrelationPage({super.key});

  @override
  ConsumerState<CorrelationPage> createState() => _CorrelationPageState();
}

class _CorrelationPageState extends ConsumerState<CorrelationPage> {
  Map<SymptomType, int>? _symptomCounts;
  List<(String, int, int)>? _suspectedFoods;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final mealRepo = ref.read(mealRepositoryProvider);
    final feedbackRepo = ref.read(feedbackRepositoryProvider);
    final now = DateTime.now();

    final counts = <SymptomType, int>{};
    final mealByDate = <String, List<MealRecord>>{};
    final symptomDays = <DateTime>{};

    for (var i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final dateKey =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final feedback = await feedbackRepo.getFeedbackByDate(date);
      if (feedback != null && feedback.symptoms.isNotEmpty) {
        symptomDays.add(date);
        for (final symptom in feedback.symptoms) {
          counts[symptom.type] = (counts[symptom.type] ?? 0) + 1;
        }
      }
      mealByDate[dateKey] = await mealRepo.getMealsByDate(date);
    }

    final suspected = _computeSuspectedFoods(mealByDate, symptomDays);

    if (mounted) {
      setState(() {
        _symptomCounts = counts;
        _suspectedFoods = suspected;
      });
    }
  }

  List<(String, int, int)> _computeSuspectedFoods(
    Map<String, List<MealRecord>> mealByDate,
    Set<DateTime> symptomDays,
  ) {
    if (symptomDays.isEmpty) return [];

    final foodCount = <String, int>{};
    final foodOnSymptomDay = <String, int>{};

    for (final entry in mealByDate.entries) {
      final date = DateTime.parse(entry.key);
      final isSymptomDay = symptomDays.any((d) =>
          d.year == date.year && d.month == date.month && d.day == date.day);
      for (final meal in entry.value) {
        for (final item in meal.foodItems) {
          final name = item.name.trim();
          if (name.isEmpty) continue;
          foodCount[name] = (foodCount[name] ?? 0) + 1;
          if (isSymptomDay) {
            foodOnSymptomDay[name] = (foodOnSymptomDay[name] ?? 0) + 1;
          }
        }
      }
    }

    final result = <(String, int, int)>[];
    foodOnSymptomDay.forEach((name, onSymptomDay) {
      if (onSymptomDay >= 2) {
        final total = foodCount[name] ?? 0;
        final noSymptomDay = total - onSymptomDay;
        result.add((name, onSymptomDay, noSymptomDay));
      }
    });
    result.sort((a, b) => b.$2.compareTo(a.$2));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('肠胃症状关联')),
      body: _symptomCounts == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSymptomFrequency(),
                const SizedBox(height: 16),
                _buildSuspectedFoods(),
              ],
            ),
    );
  }

  Widget _buildSymptomFrequency() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('近 30 天症状频率',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (_symptomCounts!.isEmpty)
              const Text('近 30 天没有肠胃症状记录',
                  style: TextStyle(color: Colors.grey))
            else
              for (final entry in _symptomCounts!.entries)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: const Icon(Icons.coronavirus, color: Colors.red),
                  title: Text(entry.key.label),
                  trailing: Text(
                    '${entry.value} 次',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuspectedFoods() {
    final suspected = _suspectedFoods ?? [];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('疑似敏感食物',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              '基于近 30 天症状发生当天饮食的统计，仅供参考',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            if (suspected.isEmpty)
              const Text('暂未发现疑似敏感食物',
                  style: TextStyle(color: Colors.grey))
            else
              for (final item in suspected)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: const Icon(Icons.restaurant, color: Colors.orange),
                  title: Text(item.$1),
                  subtitle: Text(
                      '症状日出现 ${item.$2} 次 · 无症状日出现 ${item.$3} 次'),
                ),
          ],
        ),
      ),
    );
  }
}
