import 'package:flutter/material.dart';

import 'trend_chart_page.dart';
import 'correlation_page.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分析'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            context,
            icon: Icons.show_chart,
            title: '趋势分析',
            subtitle: '查看各身体维度与体重随时间的变化',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TrendChartPage()),
            ),
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            icon: Icons.coronavirus,
            title: '肠胃症状关联',
            subtitle: '分析症状频率与疑似敏感食物',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CorrelationPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
