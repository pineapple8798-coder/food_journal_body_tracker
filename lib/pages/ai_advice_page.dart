import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/ai_service.dart';
import '../services/history_summary_builder.dart';

class AIAdvicePage extends ConsumerStatefulWidget {
  const AIAdvicePage({super.key});

  @override
  ConsumerState<AIAdvicePage> createState() => _AIAdvicePageState();
}

class _AIAdvicePageState extends ConsumerState<AIAdvicePage> {
  final _queryController = TextEditingController();
  String? _imagePath;
  bool _asking = false;
  DietAdviceResult? _result;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  Future<String> _buildHistorySummary() async {
    final mealRepo = ref.read(mealRepositoryProvider);
    final feedbackRepo = ref.read(feedbackRepositoryProvider);
    final now = DateTime.now();
    final meals = <MealRecord>[];
    final feedbacks = <BodyFeedback>[];
    for (var i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      meals.addAll(await mealRepo.getMealsByDate(date));
      final feedback = await feedbackRepo.getFeedbackByDate(date);
      if (feedback != null) feedbacks.add(feedback);
    }
    return HistorySummaryBuilder(
      meals: meals,
      feedbackList: feedbacks,
    ).build();
  }

  Future<void> _ask() async {
    final query = _queryController.text.trim();
    if (query.isEmpty && _imagePath == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('请输入食物名称或选择图片')));
      return;
    }

    setState(() {
      _asking = true;
      _result = null;
    });
    try {
      final aiService = ref.read(aiServiceProvider);
      final historySummary = await _buildHistorySummary();
      final result = await aiService.getDietAdvice(
        query: query,
        imagePath: _imagePath,
        historySummary: historySummary,
      );
      if (mounted) {
        setState(() => _result = result);
        await _saveAdvice(query, result);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('AI 建议获取失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _asking = false);
    }
  }

  Future<void> _saveAdvice(String query, DietAdviceResult result) async {
    final repo = ref.read(adviceRepositoryProvider);
    await repo.saveAdvice(
      AdviceRecord(
        queryText: query.isEmpty ? '食物图片' : query,
        queryImagePath: _imagePath,
        conclusion: result.conclusion,
        reason: result.reason,
        riskFactors: result.riskFactors,
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _imagePath = picked.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 饮食建议'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const _AdviceHistoryPage()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '问我："这个我能吃吗？"',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'AI 将结合你的历史饮食记录与肠胃症状给出个性化建议',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _queryController,
            decoration: const InputDecoration(
              hintText: '输入食物名称，如：牛奶、火锅...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          if (_imagePath != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_imagePath!),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    onPressed: () => setState(() => _imagePath = null),
                  ),
                ),
              ],
            )
          else
            OutlinedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('选择食物图片'),
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _asking ? null : _ask,
            icon: _asking
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.smart_toy),
            label: const Text('获取建议'),
            style:
                FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          ),
          const SizedBox(height: 24),
          if (_result != null) _buildResultCard(_result!),
        ],
      ),
    );
  }

  Widget _buildResultCard(DietAdviceResult result) {
    final (icon, color) = switch (result.conclusion) {
      AdviceConclusion.recommended => (Icons.check_circle, Colors.green),
      AdviceConclusion.cautious => (Icons.warning_amber, Colors.orange),
      AdviceConclusion.notRecommended => (Icons.cancel, Colors.red),
    };
    return Card(
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 8),
                Text(
                  result.conclusion.label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('原因：${result.reason}'),
            if (result.riskFactors.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text('风险因素：',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: result.riskFactors
                    .map((f) => Chip(label: Text(f)))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AdviceHistoryPage extends ConsumerStatefulWidget {
  const _AdviceHistoryPage();

  @override
  ConsumerState<_AdviceHistoryPage> createState() => _AdviceHistoryPageState();
}

class _AdviceHistoryPageState extends ConsumerState<_AdviceHistoryPage> {
  List<AdviceRecord>? _history;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = ref.read(adviceRepositoryProvider);
    final history = await repo.getAdviceHistory();
    if (mounted) setState(() => _history = history);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('建议历史')),
      body: _history == null
          ? const Center(child: CircularProgressIndicator())
          : _history!.isEmpty
              ? const Center(child: Text('暂无建议记录'))
              : ListView.builder(
                  itemCount: _history!.length,
                  itemBuilder: (context, index) {
                    final record = _history![index];
                    final color = switch (record.conclusion) {
                      AdviceConclusion.recommended => Colors.green,
                      AdviceConclusion.cautious => Colors.orange,
                      AdviceConclusion.notRecommended => Colors.red,
                    };
                    return ListTile(
                      leading: Icon(Icons.smart_toy, color: color),
                      title: Text(record.queryText),
                      subtitle: Text(
                        '${record.conclusion.label} · ${record.reason}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        '${record.createdAt.month}-${record.createdAt.day}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ),
    );
  }
}
