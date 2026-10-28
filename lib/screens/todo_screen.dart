import 'package:flutter/material.dart';
import '../models/task_item.dart';
import '../theme/app_theme.dart';

class TodoScreen extends StatefulWidget {
  final List<TaskItem> tasks;
  final Function(TaskItem) onAddTask;
  final Function(TaskItem) onToggleTask;
  final Function(String) onDeleteTask;

  const TodoScreen({
    super.key,
    required this.tasks,
    required this.onAddTask,
    required this.onToggleTask,
    required this.onDeleteTask,
  });

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TaskCategory? _selectedCategory; // null = all
  TaskPriority? _selectedPriority; // null = all
  String _searchQuery = '';

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    TaskCategory cat = TaskCategory.study;
    TaskPriority prio = TaskPriority.high;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              backgroundColor: AppColors.bgSurface,
              title: const Row(
                children: [
                  Icon(Icons.add_task_rounded, color: AppColors.cyan),
                  SizedBox(width: 10),
                  Text(
                    'إضافة مهمة جديدة إلى القائمة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: SizedBox(
                width: 480,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'عنوان المهمة *',
                        hintText: 'مثال: مذاكرة الـ Eloquent ORM 4 ساعات',
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: descController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'التفاصيل أو الملاحظات',
                        hintText: 'أي تفاصيل عن فروع الدرس أو متطلبات الكود...',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'التصنيف والتقسيم:',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: TaskCategory.values.map((c) {
                        final isSel = cat == c;
                        final temp = TaskItem(
                          id: '',
                          title: '',
                          category: c,
                          createdAt: DateTime.now(),
                        );
                        return ChoiceChip(
                          avatar: Icon(temp.categoryIcon, size: 16, color: isSel ? Colors.white : temp.categoryColor),
                          label: Text(temp.categoryArabicName),
                          selected: isSel,
                          selectedColor: temp.categoryColor.withValues(alpha: 0.3),
                          backgroundColor: AppColors.bgSurfaceLight,
                          labelStyle: TextStyle(
                            fontSize: 11,
                            color: isSel ? Colors.white : AppColors.textPrimary,
                            fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                          ),
                          onSelected: (val) {
                            if (val) setDialogState(() => cat = c);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'مستوى الأولوية:',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: TaskPriority.values.map((p) {
                        final isSel = prio == p;
                        Color pColor;
                        String pTitle;
                        switch (p) {
                          case TaskPriority.high:
                            pColor = const Color(0xFFEF4444);
                            pTitle = 'قصوى';
                            break;
                          case TaskPriority.medium:
                            pColor = const Color(0xFFF59E0B);
                            pTitle = 'متوسطة';
                            break;
                          case TaskPriority.low:
                            pColor = const Color(0xFF10B981);
                            pTitle = 'عادية';
                            break;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ChoiceChip(
                            label: Text(pTitle),
                            selected: isSel,
                            selectedColor: pColor.withValues(alpha: 0.3),
                            backgroundColor: AppColors.bgSurfaceLight,
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: isSel ? pColor : AppColors.textSecondary,
                              fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                            ),
                            onSelected: (val) {
                              if (val) setDialogState(() => prio = p);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('إلغاء', style: TextStyle(color: AppColors.textMuted)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyan,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isNotEmpty) {
                      final newTask = TaskItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: title,
                        description: descController.text.trim(),
                        category: cat,
                        priority: prio,
                        createdAt: DateTime.now(),
                      );
                      widget.onAddTask(newTask);
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text('إضافة المهمة'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = widget.tasks.where((t) {
      final matchesCategory = _selectedCategory == null || t.category == _selectedCategory;
      final matchesPriority = _selectedPriority == null || t.priority == _selectedPriority;
      final matchesSearch = _searchQuery.isEmpty ||
          t.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesPriority && matchesSearch;
    }).toList();

    // Sort: incomplete first, high priority first
    filteredTasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return b.priority.index.compareTo(a.priority.index);
    });

    final completedCount = widget.tasks.where((t) => t.isCompleted).length;
    final totalCount = widget.tasks.length;
    final percent = totalCount > 0 ? (completedCount / totalCount) : 0.0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header with Add button and Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'قائمة المهام اليومية المقسمة (To-Do List)',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'نظم وقتك بين الـ 4 ساعات مذاكرة، ساعة التطبيق، والعبادات والصحة',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: _showAddTaskDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cyan,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text(
                      'إضافة مهمة جديدة',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Progress Bar Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.task_alt_rounded, color: AppColors.emeraldGreen, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'إنجاز المهام اليوم: $completedCount من أصل $totalCount مهمة',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                        Text(
                          '${(percent * 100).toInt()}% مكتمل',
                          style: const TextStyle(
                            color: AppColors.emeraldGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: percent,
                        minHeight: 8,
                        backgroundColor: AppColors.bgSurfaceLight,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.emeraldGreen),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Search & Category Filters
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'ابحث في المهام...',
                        prefixIcon: Icon(Icons.search_rounded, color: AppColors.textMuted),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryChip('الكل', null),
                          _buildCategoryChip('📚 مذاكرة (4س)', TaskCategory.study),
                          _buildCategoryChip('💻 كود وتطبيق (1س)', TaskCategory.practice),
                          _buildCategoryChip('🕌 صلاة وعبادة', TaskCategory.spiritual),
                          _buildCategoryChip('🏃‍♂️ صحة ورياضة', TaskCategory.health),
                          _buildCategoryChip('📝 مهام عامة', TaskCategory.general),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Tasks List
              Expanded(
                child: filteredTasks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline_rounded, size: 64, color: AppColors.textMuted),
                            const SizedBox(height: 12),
                            const Text(
                              'لا توجد مهام في هذا التصنيف حالياً',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton.icon(
                              onPressed: _showAddTaskDialog,
                              icon: const Icon(Icons.add),
                              label: const Text('أضف مهمتك الأولى الآن'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return _buildTaskCard(task);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }

  Widget _buildCategoryChip(String title, TaskCategory? category) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: FilterChip(
        label: Text(title),
        selected: isSelected,
        onSelected: (val) {
          setState(() {
            _selectedCategory = category;
          });
        },
        backgroundColor: AppColors.bgSurface,
        selectedColor: AppColors.cyan.withValues(alpha: 0.2),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.cyan : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
        side: BorderSide(
          color: isSelected ? AppColors.cyan : AppColors.borderLight,
        ),
      ),
    );
  }

  Widget _buildTaskCard(TaskItem task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: task.isCompleted ? AppColors.emeraldGreen.withValues(alpha: 0.4) : AppColors.borderLight,
          width: task.isCompleted ? 1.2 : 0.8,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Transform.scale(
          scale: 1.2,
          child: Checkbox(
            value: task.isCompleted,
            activeColor: AppColors.emeraldGreen,
            onChanged: (val) {
              widget.onToggleTask(task);
            },
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: task.isCompleted ? AppColors.textMuted : AppColors.textPrimary,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: task.categoryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(task.categoryIcon, size: 12, color: task.categoryColor),
                  const SizedBox(width: 4),
                  Text(
                    task.categoryArabicName,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: task.categoryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            // Priority Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: task.priorityColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                task.priorityArabicName,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: task.priorityColor,
                ),
              ),
            ),
          ],
        ),
        subtitle: task.description.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: task.isCompleted ? AppColors.textMuted : AppColors.textSecondary,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline_rounded, color: AppColors.textMuted, size: 20),
          tooltip: 'حذف المهمة',
          onPressed: () {
            widget.onDeleteTask(task.id);
          },
        ),
      ),
    );
  }
}
