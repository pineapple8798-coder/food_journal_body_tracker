import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';
import 'ai_settings_page.dart';
import 'data_backup_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(aiConfigProvider);
    final aiConfigured = config.isConfigured;
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.settings_input_component,
                    color: aiConfigured ? Colors.green : Colors.orange,
                  ),
                  title: const Text('AI 服务设置'),
                  subtitle: Text(
                    aiConfigured
                        ? '已配置（${config.model}）'
                        : '未配置 API Key / Base URL',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AiSettingsPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.backup_outlined),
                  title: const Text('数据备份'),
                  subtitle: const Text('导出或恢复全部记录'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DataBackupPage()),
                  ),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('关于'),
                  subtitle: Text('AI 美食日记 · 身体反馈追踪 v1.0.0'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
