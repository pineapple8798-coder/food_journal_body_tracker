import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db_utils.dart';
import '../providers/app_providers.dart';
import 'day_detail_page.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  late DateTime _currentMonth;
  Set<String> _markedDates = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
    _loadMarks();
  }

  Future<void> _loadMarks() async {
    final mealRepo = ref.read(mealRepositoryProvider);
    final feedbackRepo = ref.read(feedbackRepositoryProvider);
    final marks = <String>{};
    final next = DateTime(_currentMonth.year, _currentMonth.month + 1);
    for (var day = _currentMonth;
        day.isBefore(next);
        day = day.add(const Duration(days: 1))) {
      final meals = await mealRepo.getMealsByDate(day);
      final feedback = await feedbackRepo.getFeedbackByDate(day);
      if (meals.isNotEmpty || feedback != null) {
        marks.add(DbUtils.formatDateKey(day));
      }
    }
    if (mounted) setState(() => _markedDates = marks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_currentMonth.year}年${_currentMonth.month}月'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _currentMonth =
                  DateTime(_currentMonth.year, _currentMonth.month - 1);
            });
            _loadMarks();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _currentMonth =
                    DateTime(_currentMonth.year, _currentMonth.month + 1);
              });
              _loadMarks();
            },
          ),
          TextButton(
            onPressed: () {
              final now = DateTime.now();
              setState(() {
                _currentMonth = DateTime(now.year, now.month);
              });
              _loadMarks();
            },
            child: const Text('今天'),
          ),
        ],
      ),
      body: _buildCalendar(),
    );
  }

  Widget _buildCalendar() {
    final weekHeader = ['一', '二', '三', '四', '五', '六', '日'];
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final leadingBlanks = (firstDay.weekday - 1) % 7;
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    return Column(
      children: [
        Row(
          children: weekHeader
              .map((w) => Expanded(
                    child: Center(
                      child: Text(w,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ))
              .toList(),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: leadingBlanks + daysInMonth,
            itemBuilder: (context, index) {
              if (index < leadingBlanks) {
                return const SizedBox.shrink();
              }
              final day = index - leadingBlanks + 1;
              final date = DateTime(
                  _currentMonth.year, _currentMonth.month, day);
              final dateKey = DbUtils.formatDateKey(date);
              final hasRecord = _markedDates.contains(dateKey);
              return InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DayDetailPage(date: date),
                    ),
                  );
                  _loadMarks();
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: hasRecord
                        ? Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withValues(alpha: 0.6)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$day', style: const TextStyle(fontSize: 16)),
                      if (hasRecord)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
