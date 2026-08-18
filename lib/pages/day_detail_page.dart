import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import 'meal_form_page.dart';
import 'body_feedback_page.dart';

class DayDetailPage extends ConsumerStatefulWidget {
  const DayDetailPage({super.key, required this.date});

  final DateTime date;

  @override
  ConsumerState<DayDetailPage> createState() => _DayDetailPageState();
}

class _DayDetailPageState extends ConsumerState<DayDetailPage> {
  List<MealRecord> _meals = [];
  BodyFeedback? _feedback;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final mealRepo = ref.read(mealRepositoryProvider);
    final feedbackRepo = ref.read(feedbackRepositoryProvider);
    final meals = await mealRepo.getMealsByDate(widget.date);
    final feedback = await feedbackRepo.getFeedbackByDate(widget.date);
    if (mounted) {
      setState(() {
        _meals = meals;
        _feedback = feedback;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = DateFormat('yyyy年M月d日', 'zh_CN').format(widget.date);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildFeedbackSection(),
                  const SizedBox(height: 16),
                  _buildMealsSection(),
                  const SizedBox(height: 24),
                  _buildActions(),
                ],
              ),
            ),
    );
  }

  Widget _buildFeedbackSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('身体反馈',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                if (_feedback != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: _deleteFeedback,
                    tooltip: '删除反馈',
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (_feedback == null)
              const Text('当天未填写身体反馈', style: TextStyle(color: Colors.grey))
            else ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (_feedback!.energyScore != null)
                    Chip(label: Text('精力 ${_feedback!.energyScore}/5')),
                  if (_feedback!.digestionScore != null)
                    Chip(label: Text('消化 ${_feedback!.digestionScore}/5')),
                  if (_feedback!.sleepScore != null)
                    Chip(label: Text('睡眠 ${_feedback!.sleepScore}/5')),
                  if (_feedback!.stomachScore != null)
                    Chip(label: Text('肠胃 ${_feedback!.stomachScore}/5')),
                  if (_feedback!.skinScore != null)
                    Chip(label: Text('皮肤 ${_feedback!.skinScore}/5')),
                  if (_feedback!.weight != null)
                    Chip(label: Text('体重 ${_feedback!.weight}kg')),
                ],
              ),
              if (_feedback!.symptoms.isNotEmpty) ...[
                const SizedBox(height: 8),
                ..._feedback!.symptoms.map(
                  (s) => Chip(
                    label: Text('${s.type.label} (${s.severity.label})'),
                    backgroundColor: Colors.red.shade50,
                  ),
                ),
              ],
              if (_feedback!.note.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('备注：${_feedback!.note}'),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMealsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('饮食记录',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (_meals.isEmpty)
              const Text('当天没有饮食记录', style: TextStyle(color: Colors.grey))
            else
              for (final meal in _meals) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(meal.mealType.label,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final item in meal.foodItems)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.file(
                                  File(item.imagePath),
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 40,
                                    height: 40,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image,
                                        size: 20, color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name),
                                    if (item.comment.isNotEmpty)
                                      Text(item.comment,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _editMeal(meal),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.red),
                        onPressed: () => _deleteMeal(meal),
                        tooltip: '删除餐次',
                      ),
                    ],
                  ),
                  onTap: () => _editMeal(meal),
                ),
                const Divider(),
              ],
          ],
        ),
      ),
    );
  }

  Future<void> _editMeal(MealRecord meal) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealFormPage(date: widget.date, meal: meal),
      ),
    );
    _load();
  }

  Future<void> _deleteMeal(MealRecord meal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除餐次'),
        content: Text('确定删除「${meal.mealType.label}」这餐记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final repo = ref.read(mealRepositoryProvider);
    await repo.deleteMeal(meal.id!);
    _load();
  }

  Future<void> _deleteFeedback() async {
    final feedback = _feedback;
    if (feedback == null || feedback.id == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除身体反馈'),
        content: const Text('确定删除当天的身体反馈吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final repo = ref.read(feedbackRepositoryProvider);
    await repo.deleteFeedback(feedback.id!);
    _load();
  }

  Future<void> _addMeal() async {
    MealRecord? target;
    if (_meals.isNotEmpty) {
      final choice = await showModalBottomSheet<Object?>(
        context: context,
        builder: (ctx) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '当天已有 ${_meals.length} 餐记录，选择要编辑的餐次或新增',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final meal in _meals)
                      ListTile(
                        leading: const Icon(Icons.restaurant),
                        title: Text(meal.mealType.label),
                        subtitle: Text(
                          meal.foodItems.map((i) => i.name).join('、'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => Navigator.pop(ctx, meal),
                      ),
                    ListTile(
                      leading: const Icon(Icons.add_circle_outline),
                      title: const Text('新增餐次'),
                      onTap: () => Navigator.pop(ctx, 'add'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      if (choice == null) return;
      if (choice is MealRecord) target = choice;
    }
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealFormPage(date: widget.date, meal: target),
      ),
    );
    _load();
  }

  Widget _buildActions() {
    return Column(
      children: [
        OutlinedButton.icon(
          onPressed: _addMeal,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('补录餐次'),
          style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BodyFeedbackPage(date: widget.date),
              ),
            );
            _load();
          },
          icon: const Icon(Icons.health_and_safety),
          label: const Text('补录身体反馈'),
          style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
        ),
      ],
    );
  }
}
