import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import 'meal_form_page.dart';
import 'body_feedback_page.dart';
import 'ai_advice_page.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  List<MealRecord>? _meals;
  BodyFeedback? _feedback;
  ({int streak, int monthCount})? _stats;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final mealRepo = ref.read(mealRepositoryProvider);
    final feedbackRepo = ref.read(feedbackRepositoryProvider);
    final now = DateTime.now();
    final meals = await mealRepo.getMealsByDate(now);
    final feedback = await feedbackRepo.getFeedbackByDate(now);
    final stats = await _loadStats(mealRepo, feedbackRepo, now);
    if (mounted) {
      setState(() {
        _meals = meals;
        _feedback = feedback;
        _stats = stats;
      });
    }
  }

  Future<({int streak, int monthCount})> _loadStats(
    dynamic mealRepo,
    dynamic feedbackRepo,
    DateTime now,
  ) async {
    var streak = 0;
    var cursor = now;
    while (true) {
      final meals = await mealRepo.getMealsByDate(cursor);
      final feedback = await feedbackRepo.getFeedbackByDate(cursor);
      if (meals.isNotEmpty || feedback != null) {
        streak++;
        cursor = cursor.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    var monthCount = 0;
    final firstOfMonth = DateTime(now.year, now.month);
    for (var day = firstOfMonth;
        day.isBefore(DateTime(now.year, now.month + 1));
        day = day.add(const Duration(days: 1))) {
      final meals = await mealRepo.getMealsByDate(day);
      final feedback = await feedbackRepo.getFeedbackByDate(day);
      if (meals.isNotEmpty || feedback != null) monthCount++;
    }
    return (streak: streak, monthCount: monthCount);
  }

  Future<void> _pushAndReload(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final todayLabel = DateFormat('M月d日 EEEE', 'zh_CN').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text('今天 $todayLabel'),
        automaticallyImplyLeading: false,
      ),
      body: _meals == null || _stats == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildStatsCard(),
                  const SizedBox(height: 16),
                  _buildRecordSection(),
                  const SizedBox(height: 16),
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsCard() {
    final stats = _stats!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _statItem('${stats.streak}', '连续记录(天)'),
            _statItem('${stats.monthCount}', '本月记录(天)'),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildRecordSection() {
    final meals = _meals!;
    final feedback = _feedback;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('今日记录',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('饮食记录：${meals.length} 餐'),
            if (meals.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text('今天还没有记录饮食', style: TextStyle(color: Colors.grey)),
              ),
            const SizedBox(height: 8),
            Text('身体反馈：${feedback == null ? '未填写' : '已填写'}'),
            if (feedback == null)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text('今天还没有填写身体反馈',
                    style: TextStyle(color: Colors.grey)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        FilledButton.icon(
          onPressed: () => _pushAndReload(const MealFormPage()),
          icon: const Icon(Icons.camera_alt),
          label: const Text('记录美食'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => _pushAndReload(const BodyFeedbackPage()),
          icon: const Icon(Icons.health_and_safety),
          label: const Text('记录身体反馈'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () => _pushAndReload(const AIAdvicePage()),
          icon: const Icon(Icons.smart_toy),
          label: const Text('AI 饮食建议'),
        ),
      ],
    );
  }
}
