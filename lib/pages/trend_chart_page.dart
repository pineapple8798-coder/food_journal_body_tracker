import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';

enum TrendDimension {
  energy('精力'),
  digestion('消化'),
  sleep('睡眠'),
  stomach('肠胃'),
  skin('皮肤'),
  weight('体重');

  const TrendDimension(this.label);

  final String label;
}

class TrendChartPage extends ConsumerStatefulWidget {
  const TrendChartPage({super.key});

  @override
  ConsumerState<TrendChartPage> createState() => _TrendChartPageState();
}

class _TrendChartPageState extends ConsumerState<TrendChartPage> {
  TrendDimension _dimension = TrendDimension.energy;
  List<BodyFeedback>? _feedbacks;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = ref.read(feedbackRepositoryProvider);
    final now = DateTime.now();
    final feedbacks = <BodyFeedback>[];
    for (var i = 29; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final feedback = await repo.getFeedbackByDate(date);
      if (feedback != null) feedbacks.add(feedback);
    }
    if (mounted) setState(() => _feedbacks = feedbacks);
  }

  double? _valueFor(BodyFeedback feedback) {
    return switch (_dimension) {
      TrendDimension.energy => feedback.energyScore?.toDouble(),
      TrendDimension.digestion => feedback.digestionScore?.toDouble(),
      TrendDimension.sleep => feedback.sleepScore?.toDouble(),
      TrendDimension.stomach => feedback.stomachScore?.toDouble(),
      TrendDimension.skin => feedback.skinScore?.toDouble(),
      TrendDimension.weight => feedback.weight,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('趋势分析')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<TrendDimension>(
              segments: TrendDimension.values
                  .map((d) => ButtonSegment(value: d, label: Text(d.label)))
                  .toList(),
              selected: {_dimension},
              onSelectionChanged: (s) => setState(() => _dimension = s.first),
            ),
          ),
          Expanded(
            child: _feedbacks == null
                ? const Center(child: CircularProgressIndicator())
                : _feedbacks!.isEmpty
                    ? const Center(
                        child: Text('数据不足，请先坚持记录几天身体反馈'),
                      )
                    : _buildChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    final points = <FlSpot>[];
    for (var i = 0; i < _feedbacks!.length; i++) {
      final feedback = _feedbacks![i];
      final value = _valueFor(feedback);
      if (value != null) {
        points.add(FlSpot(i.toDouble(), value));
      }
    }

    if (points.length < 2) {
      return const Center(child: Text('数据不足 2 天，建议持续记录'));
    }

    final maxY = _dimension == TrendDimension.weight
        ? (points.map((p) => p.y).reduce((a, b) => a > b ? a : b) + 2)
        : 5.5;
    final minY = _dimension == TrendDimension.weight
        ? (points.map((p) => p.y).reduce((a, b) => a < b ? a : b) - 2)
        : 0.0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          minY: minY,
          maxY: maxY,
          gridData: const FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 5,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: points,
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
