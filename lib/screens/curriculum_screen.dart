import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/curriculum_data.dart';
import '../models/curriculum_day.dart';
import '../models/task_item.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class CurriculumScreen extends StatefulWidget {
  final Function(TaskItem) onAddTaskToTodo;
  final VoidCallback onDayStatusChanged;

  const CurriculumScreen({
    super.key,
    required this.onAddTaskToTodo,
    required this.onDayStatusChanged,
  });

  @override
  State<CurriculumScreen> createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  List<CurriculumDay> _allDays = [];
  Set<int> _completedDayNumbers = {};
  int _selectedPhaseId = 0; // 0 = all
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _allDays = CurriculumData.getFullCurriculum();
    final completed = await StorageService.loadCompletedDays();
    setState(() {
      _completedDayNumbers = completed;
      for (var d in _allDays) {
        d.isCompleted = _completedDayNumbers.contains(d.dayNumber);
      }
    });
  }

  Future<void> _toggleDayCompletion(CurriculumDay day) async {
    setState(() {
      if (_completedDayNumbers.contains(day.dayNumber)) {
        _completedDayNumbers.remove(day.dayNumber);
        day.isCompleted = false;
      } else {
        _completedDayNumbers.add(day.dayNumber);
        day.isCompleted = true;
      }
    });
    await StorageService.saveCompletedDays(_completedDayNumbers);
    widget.onDayStatusChanged();

    if (mounted && day.isCompleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.emeraldGreen,
          content: Row(
            children: [
              const Icon(Icons.celebration_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Text('ما شاء الله! أحسنت إنجاز اليوم ${day.dayNumber}: ${day.title}'),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.redLaravel,
            content: Text('تعذر فتح الرابط: $url'),
          ),
        );
      }
    }
  }

  void _addDayTasksToTodoList(CurriculumDay day) {
    // 1. Add 4h Study Task
    final studyTask = TaskItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'مذاكرة اليوم ${day.dayNumber}: ${day.title}',
      description: 'إتمام 4 ساعات دراسة:\n${day.fourHourStudyGoals.join('\n')}',
      category: TaskCategory.study,
      priority: TaskPriority.high,
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    // 2. Add 1h Practice Task
    final practiceTask = TaskItem(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      title: 'ساعة التطبيق العملي اليوم ${day.dayNumber}',
      description: day.oneHourPracticeGoal,
      category: TaskCategory.practice,
      priority: TaskPriority.high,
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    widget.onAddTaskToTodo(studyTask);
    widget.onAddTaskToTodo(practiceTask);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.blueFlutter,
        content: Row(
          children: [
            const Icon(Icons.playlist_add_check_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Text('تمت إضافة مهام اليوم ${day.dayNumber} (المذاكرة والتطبيق) إلى قائمة الـ To-Do بنجاح!'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredDays = _allDays.where((day) {
      final matchesPhase = _selectedPhaseId == 0 || day.phaseId == _selectedPhaseId;
      final matchesSearch = _searchQuery.isEmpty ||
          day.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          day.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          day.phaseTitle.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesPhase && matchesSearch;
    }).toList();

    final totalCompleted = _completedDayNumbers.length;
    final totalDays = _allDays.length;
    final completionPercent = totalDays > 0 ? (totalCompleted / totalDays) : 0.0;

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
              // Header & Progress Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'خطة المذاكرة الاحترافية (4 ساعات + 1 ساعة تطبيق)',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'رحلة التعلم من الصفر حتى Mid-Level Full-Stack في Flutter & Laravel',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  // Progress pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.bgSurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            value: completionPercent,
                            strokeWidth: 4,
                            backgroundColor: AppColors.bgSurfaceLight,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$totalCompleted من أصل $totalDays يوم',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'نسبة إنجاز الخطة: ${(completionPercent * 100).toInt()}%',
                              style: const TextStyle(
                                color: AppColors.cyan,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar & Phase Filters
              Row(
                children: [
                  // Search TextField
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'ابحث عن موضوع، مكتبة، أو درس (مثل: Eloquent, Sanctum, Cubit, Git)...',
                        prefixIcon: Icon(Icons.search_rounded, color: AppColors.textMuted),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Phase Filters
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('الكل', 0),
                          _buildFilterChip('1: التأسيس', 1),
                          _buildFilterChip('2: PHP & MySQL', 2),
                          _buildFilterChip('3: Laravel & APIs', 3),
                          _buildFilterChip('4: Dart OOP', 4),
                          _buildFilterChip('5: Flutter', 5),
                          _buildFilterChip('6: الربط الكامل والمشاريع', 6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Curriculum Days List
              Expanded(
                child: filteredDays.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off_rounded, size: 64, color: AppColors.textMuted),
                            const SizedBox(height: 12),
                            const Text(
                              'لا توجد دروس تطابق بحثك',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredDays.length,
                        itemBuilder: (context, index) {
                          final day = filteredDays[index];
                          return _buildDayCard(day);
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

  Widget _buildFilterChip(String label, int phaseId) {
    final isSelected = _selectedPhaseId == phaseId;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {
          setState(() {
            _selectedPhaseId = phaseId;
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

  Widget _buildDayCard(CurriculumDay day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: day.isCompleted ? AppColors.emeraldGreen.withValues(alpha: 0.6) : AppColors.borderLight,
          width: day.isCompleted ? 1.5 : 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: day.isCompleted
                  ? AppColors.emeraldGradient
                  : AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: day.isCompleted
                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 26)
                  : Text(
                      '${day.dayNumber}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  day.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: day.isCompleted ? AppColors.emeraldGreen : AppColors.textPrimary,
                    decoration: day.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.bgSurfaceLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Text(
                  day.phaseBadge,
                  style: const TextStyle(
                    color: AppColors.cyan,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              day.description,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: AppColors.borderLight),
                  const SizedBox(height: 10),

                  // 4 Hours Study Goals Breakdown
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.cyan.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.menu_book_rounded, color: AppColors.cyan, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'جدول الـ 4 ساعات مذاكرة مركزة اليوم:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cyan,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...day.fourHourStudyGoals.map((goal) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(color: AppColors.cyan, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                goal,
                                style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      )),

                  const SizedBox(height: 16),

                  // 1 Hour Practice Coding Project
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.purpleViolet.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.purpleViolet.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.purpleViolet.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.code_rounded, color: AppColors.purpleViolet, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'مشروع ساعة التطبيق العملي (1 ساعة كود فعلي):',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color(0xFFC084FC),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                day.oneHourPracticeGoal,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Lessons and Docs Links
                  if (day.links.isNotEmpty) ...[
                    const Text(
                      'مصادر الدروس والشروحات الموصى بها:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: day.links.map((link) {
                        return ElevatedButton.icon(
                          onPressed: () => _openLink(link.url),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bgSurfaceLight,
                            foregroundColor: AppColors.textPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: AppColors.borderLight),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          ),
                          icon: Icon(
                            link.type == 'doc' ? Icons.description_rounded : Icons.play_circle_fill_rounded,
                            size: 18,
                            color: link.type == 'doc' ? AppColors.cyan : AppColors.redLaravel,
                          ),
                          label: Text(
                            '${link.title} (${link.sourceName})',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 18),
                  ],

                  // Action Buttons row
                  Row(
                    children: [
                      // Toggle Complete Button
                      ElevatedButton.icon(
                        onPressed: () => _toggleDayCompletion(day),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: day.isCompleted ? AppColors.emeraldGreen : AppColors.blueFlutter,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: Icon(day.isCompleted ? Icons.check_circle_rounded : Icons.done_all_rounded, size: 18),
                        label: Text(
                          day.isCompleted ? 'مكتمل بنجاح (اضغط للإلغاء)' : 'تحديد اليوم كمكتمل',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Add to Todo Button
                      OutlinedButton.icon(
                        onPressed: () => _addDayTasksToTodoList(day),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.cyan,
                          side: const BorderSide(color: AppColors.cyan),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.add_task_rounded, size: 18),
                        label: const Text(
                          'إضافة مهام اليوم إلى الـ To-Do',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
