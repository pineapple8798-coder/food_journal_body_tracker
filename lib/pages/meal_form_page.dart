import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/models.dart';
import '../models/validators.dart';
import '../providers/app_providers.dart';

class MealFormPage extends ConsumerStatefulWidget {
  const MealFormPage({super.key, this.date, this.meal});

  final DateTime? date;
  final MealRecord? meal;

  @override
  ConsumerState<MealFormPage> createState() => _MealFormPageState();
}

class _MealFormPageState extends ConsumerState<MealFormPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  late MealType _mealType;
  final List<_DraftFoodItem> _foodItems = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _date = widget.date ?? DateTime.now();
    _mealType = widget.meal?.mealType ?? _defaultMealType();
    if (widget.meal != null) {
      for (final item in widget.meal!.foodItems) {
        _foodItems.add(_DraftFoodItem.fromItem(item));
      }
    }
  }

  MealType _defaultMealType() {
    final hour = DateTime.now().hour;
    if (hour < 10) return MealType.breakfast;
    if (hour < 15) return MealType.lunch;
    if (hour < 21) return MealType.dinner;
    return MealType.snack;
  }

  Future<void> _pickImage(_DraftFoodItem item) async {
    final showSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('拍照'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('从相册选择'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (showSource == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: showSource, maxWidth: 1200);
    if (picked == null) return;

    if (mounted) {
      setState(() {
        item.imagePath = picked.path;
        item.localFile = File(picked.path);
      });
    }

    await _recognize(item);
  }

  Future<void> _recognize(_DraftFoodItem item) async {
    final aiService = ref.read(aiServiceProvider);
    setState(() => item.recognizing = true);
    try {
      final result = await aiService.recognizeFood(imagePath: item.imagePath!);
      if (mounted && item.imagePath != null) {
        setState(() {
          item.nameController.text = result.name;
          item.aiRecognized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        _showSnack('AI 识别失败：$e，可手动填写食物名称');
      }
    } finally {
      if (mounted) setState(() => item.recognizing = false);
    }
  }

  Future<void> _save() async {
    if (_foodItems.isEmpty) {
      _showSnack('请至少添加一个食物条目');
      return;
    }
    final meal = MealRecord(
      id: widget.meal?.id,
      date: _date,
      mealType: _mealType,
      foodItems: _foodItems.map((d) => d.toModel()).toList(),
    );
    final error = MealValidator.validateMeal(meal);
    if (error != null) {
      _showSnack(error);
      return;
    }

    setState(() => _saving = true);
    try {
      final repo = ref.read(mealRepositoryProvider);
      await repo.saveMeal(meal);
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (_) {
      _showSnack('保存失败，请重试');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.meal == null ? '记录美食' : '编辑餐次')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildDateAndMealType(),
            const SizedBox(height: 16),
            for (var i = 0; i < _foodItems.length; i++) ...[
              _buildFoodItemCard(_foodItems[i], i),
              const SizedBox(height: 12),
            ],
            OutlinedButton.icon(
              onPressed: () => setState(() {
                _foodItems.add(_DraftFoodItem());
              }),
              icon: const Icon(Icons.add),
              label: const Text('添加食物'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: _saving
                  ? const CircularProgressIndicator()
                  : const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateAndMealType() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: Text(
                '${_date.year}年${_date.month}月${_date.day}日',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) setState(() => _date = picked);
              },
            ),
            const Divider(height: 1),
            SegmentedButton<MealType>(
              segments: MealType.values
                  .map((t) => ButtonSegment(value: t, label: Text(t.label)))
                  .toList(),
              selected: {_mealType},
              onSelectionChanged: (s) => setState(() => _mealType = s.first),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItemCard(_DraftFoodItem item, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('食物 ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => setState(() => _foodItems.removeAt(index)),
                ),
              ],
            ),
            InkWell(
              onTap: () => _pickImage(item),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: item.imagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          item.localFile ?? File(item.imagePath!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 32, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('拍照或选择图片',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
              ),
            ),
            if (item.recognizing) ...[
              const SizedBox(height: 8),
              const LinearProgressIndicator(),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: item.nameController,
              decoration: const InputDecoration(
                labelText: '食物名称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: item.commentController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: '评价',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DraftFoodItem {
  _DraftFoodItem() : nameController = TextEditingController(),
        commentController = TextEditingController();

  _DraftFoodItem.fromItem(FoodItem item)
      : imagePath = item.imagePath,
        nameController = TextEditingController(text: item.name),
        commentController = TextEditingController(text: item.comment),
        aiRecognized = item.aiRecognized,
        aiConfidence = item.aiConfidence;

  String? imagePath;
  File? localFile;
  final TextEditingController nameController;
  final TextEditingController commentController;
  bool aiRecognized = false;
  double? aiConfidence;
  bool recognizing = false;

  FoodItem toModel() {
    return FoodItem(
      mealRecordId: '',
      imagePath: imagePath ?? '',
      name: nameController.text.trim(),
      comment: commentController.text.trim(),
      aiRecognized: aiRecognized,
      aiConfidence: aiConfidence,
    );
  }
}
