import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../models/validators.dart';
import '../providers/app_providers.dart';

class BodyFeedbackPage extends ConsumerStatefulWidget {
  const BodyFeedbackPage({super.key, this.date});

  final DateTime? date;

  @override
  ConsumerState<BodyFeedbackPage> createState() => _BodyFeedbackPageState();
}

class _BodyFeedbackPageState extends ConsumerState<BodyFeedbackPage> {
  late DateTime _date;
  int? _energy;
  int? _digestion;
  int? _sleep;
  int? _stomach;
  int? _skin;
  double? _weight;
  final _noteController = TextEditingController();
  final Map<SymptomType, Severity> _symptoms = {};
  String? _existingId;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _date = widget.date ?? DateTime.now();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    final repo = ref.read(feedbackRepositoryProvider);
    final existing = await repo.getFeedbackByDate(_date);
    if (existing != null && mounted) {
      setState(() {
        _existingId = existing.id;
        _energy = existing.energyScore;
        _digestion = existing.digestionScore;
        _sleep = existing.sleepScore;
        _stomach = existing.stomachScore;
        _skin = existing.skinScore;
        _weight = existing.weight;
        _noteController.text = existing.note;
        for (final s in existing.symptoms) {
          _symptoms[s.type] = s.severity;
        }
      });
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _save() async {
    final feedback = BodyFeedback(
      id: _existingId,
      date: _date,
      energyScore: _energy,
      digestionScore: _digestion,
      sleepScore: _sleep,
      stomachScore: _stomach,
      skinScore: _skin,
      weight: _weight,
      note: _noteController.text.trim(),
      symptoms: _symptoms.entries
          .map((e) => GutSymptom(
                feedbackId: '',
                type: e.key,
                severity: e.value,
              ))
          .toList(),
    );
    final error = MealValidator.validateFeedback(feedback);
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    setState(() => _saving = true);
    try {
      final repo = ref.read(feedbackRepositoryProvider);
      await repo.saveFeedback(feedback);
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('保存失败，请重试')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('身体反馈')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDatePicker(),
                const SizedBox(height: 16),
                _buildScoreCard('精力', Icons.bolt, _energy, (v) => _energy = v),
                _buildScoreCard(
                    '消化', Icons.local_dining, _digestion, (v) => _digestion = v),
                _buildScoreCard(
                    '睡眠', Icons.bedtime, _sleep, (v) => _sleep = v),
                _buildScoreCard(
                    '肠胃', Icons.healing, _stomach, (v) => _stomach = v),
                _buildScoreCard(
                    '皮肤', Icons.face, _skin, (v) => _skin = v),
                const SizedBox(height: 8),
                _buildWeightCard(),
                const SizedBox(height: 16),
                _buildSymptomSection(),
                const SizedBox(height: 16),
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: '备注',
                    hintText: '记录今天的身体感受...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48)),
                  child: _saving
                      ? const CircularProgressIndicator()
                      : const Text('保存'),
                ),
              ],
            ),
    );
  }

  Widget _buildDatePicker() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text('${_date.year}年${_date.month}月${_date.day}日'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: _date,
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            setState(() => _date = picked);
            _loadExisting();
          }
        },
      ),
    );
  }

  Widget _buildScoreCard(
      String label, IconData icon, int? value, ValueChanged<int?> onChanged) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            for (var score = 1; score <= 5; score++)
              IconButton(
                onPressed: () => setState(() => onChanged(value == score ? null : score)),
                icon: Icon(
                  value != null && score <= value
                      ? Icons.star
                      : Icons.star_border,
                  color: value != null && score <= value
                      ? Colors.amber
                      : Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightCard() {
    final controller = TextEditingController(
      text: _weight?.toString() ?? '',
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.monitor_weight),
            const SizedBox(width: 12),
            const Text('体重', style: TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: 100,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() {
                  _weight = double.tryParse(v);
                }),
              ),
            ),
            const SizedBox(width: 8),
            const Text('kg'),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('肠胃症状',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final type in SymptomType.values)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(type.label),
                value: _symptoms.containsKey(type),
                onChanged: (checked) => setState(() {
                  if (checked == true) {
                    _symptoms[type] = Severity.mild;
                  } else {
                    _symptoms.remove(type);
                  }
                }),
                secondary: _symptoms.containsKey(type)
                    ? DropdownButton<Severity>(
                        value: _symptoms[type],
                        items: Severity.values
                            .map((s) =>
                                DropdownMenuItem(value: s, child: Text(s.label)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _symptoms[type] = v ?? Severity.mild),
                      )
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
