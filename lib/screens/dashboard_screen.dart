import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/curriculum_data.dart';
import '../models/curriculum_day.dart';
import '../models/habit_item.dart';
import '../models/task_item.dart';
import '../services/storage_service.dart';
import '../services/timer_service.dart';
import '../theme/app_theme.dart';
import '../widgets/prayer_banner.dart';

class DashboardScreen extends StatefulWidget {
  final List<TaskItem> tasks;
  final List<HabitItem> habits;
  final Function(int) onNavigateToTab;
  final Function(TaskItem) onToggleTask;
  final Function(HabitItem) onToggleHabit;
  final Function(TaskItem) onAddTask;

  const DashboardScreen({
    super.key,
    required this.tasks,
    required this.habits,
    required this.onNavigateToTab,
    required this.onToggleTask,
    required this.onToggleHabit,
    required this.onAddTask,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Set<int> _completedDays = {};
  int _streak = 1;
  CurriculumDay? _todayCurriculum;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    final completed = await StorageService.loadCompletedDays();
    final streak = await StorageService.getStreak();
    final allDays = CurriculumData.getFullCurriculum();

    // Find the next active day
    CurriculumDay active = allDays.first;
    for (var d in allDays) {
      if (!completed.contains(d.dayNumber)) {
        active = d;
        break;
      }
    }

    setState(() {
      _completedDays = completed;
      _streak = streak;
      _todayCurriculum = active;
    });
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = widget.tasks.where((t) => t.isCompleted).length;
    final totalTasks = widget.tasks.length;
    final taskPercent = totalTasks > 0 ? (completedTasks / totalTasks) : 0.0;

    final completedHabits = widget.habits.where((h) => h.isCompleted).length;
    final totalHabits = widget.habits.length;
    final habitPercent = totalHabits > 0 ? (completedHabits / totalHabits) : 0.0;

    final timer = TimerService();
    final studyMinutes = timer.totalStudySecondsToday ~/ 60;
    final studyHours = (studyMinutes / 60).toStringAsFixed(1);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SelectionArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Prayer Times Banner
              const PrayerBanner(),
              const SizedBox(height: 20),

              // Hero Welcome Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppColors.cardGradient,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // App Logo
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cyan.withValues(alpha: 0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            'assets/images/logo.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'تاركت | Tarket Dev Roadmap',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'من الصفر إلى Mid-Level',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.emeraldGreen.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.emeraldGreen),
                                ),
                                child: Text(
                                  'أنجزت ${_completedDays.length} يوم من 30',
                                  style: const TextStyle(
                                    color: AppColors.emeraldGreen,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'نظامك المتكامل لإتقان Flutter & Laravel: أربع ساعات مذاكرة + ساعة تطبيق عملي، مع انضباط الصلاة والصحة.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Current Streak Chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: AppColors.laravelGradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 28),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'الالتزام المستمر',
                                style: TextStyle(fontSize: 11, color: Colors.white70),
                              ),
                              Text(
                                '$_streak أيام متتالية',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
              const SizedBox(height: 20),

              // Quick Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'هدف المذاكرة اليوم',
                      value: '$studyHours / 4.0 ساعات',
                      subtitle: 'تم إنجاز $studyMinutes دقيقة دراسة اليوم',
                      icon: Icons.timer_rounded,
                      color: AppColors.cyan,
                      progress: (studyMinutes / 240).clamp(0.0, 1.0),
                      actionLabel: 'بدء المؤقت',
                      onAction: () => widget.onNavigateToTab(3), // Timer Tab
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'التطبيق العملي (كود)',
                      value: '1 ساعة يومياً',
                      subtitle: _todayCurriculum?.oneHourPracticeGoal ?? 'مشاريع عملية يومية',
                      icon: Icons.code_rounded,
                      color: AppColors.purpleViolet,
                      progress: 0.5,
                      actionLabel: 'استعراض المشروع',
                      onAction: () => widget.onNavigateToTab(1), // Curriculum Tab
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'مهام الـ To-Do اليوم',
                      value: '$completedTasks من $totalTasks مهمة',
                      subtitle: '${(taskPercent * 100).toInt()}% من مهامك منجزة',
                      icon: Icons.task_alt_rounded,
                      color: AppColors.blueFlutter,
                      progress: taskPercent,
                      actionLabel: 'فتح الـ To-Do',
                      onAction: () => widget.onNavigateToTab(2), // Todo Tab
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'الصلوات والعادات',
                      value: '$completedHabits من $totalHabits التزام',
                      subtitle: '${(habitPercent * 100).toInt()}% نسبة الانضباط',
                      icon: Icons.favorite_rounded,
                      color: AppColors.emeraldGreen,
                      progress: habitPercent,
                      actionLabel: 'متابعة الالتزام',
                      onAction: () => widget.onNavigateToTab(4), // Habits Tab
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Active Lesson Spotlight Card
              if (_todayCurriculum != null) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.cyan.withValues(alpha: 0.5), width: 1.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.cyan.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.school_rounded, color: AppColors.cyan, size: 22),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'درس اليوم المقترح: اليوم ${_todayCurriculum!.dayNumber} - ${_todayCurriculum!.title}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.bgSurfaceLight,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          _todayCurriculum!.phaseBadge,
                                          style: const TextStyle(color: AppColors.cyan, fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _todayCurriculum!.description,
                                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () => widget.onNavigateToTab(1),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cyan,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                            label: const Text('الذهاب للمنهج الكامل'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Divider(color: AppColors.borderLight),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 4 Hours breakdown overview
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'خطة الـ 4 ساعات مذاكرة اليوم:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: AppColors.cyan,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                ..._todayCurriculum!.fourHourStudyGoals.map((g) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                      child: Row(
                                        children: [
                                          const Text('• ', style: TextStyle(color: AppColors.cyan)),
                                          Expanded(
                                            child: Text(
                                              g,
                                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // 1 Hour practice card
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.purpleViolet.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.purpleViolet.withValues(alpha: 0.3)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.code_rounded, color: AppColors.purpleViolet, size: 16),
                                      SizedBox(width: 6),
                                      Text(
                                        'ساعة التطبيق العملي (كود):',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xFFC084FC),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _todayCurriculum!.oneHourPracticeGoal,
                                    style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // Links buttons
                      if (_todayCurriculum!.links.isNotEmpty)
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: _todayCurriculum!.links.map((link) {
                            return ElevatedButton.icon(
                              onPressed: () => _openUrl(link.url),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.bgSurfaceLight,
                                foregroundColor: AppColors.textPrimary,
                                side: const BorderSide(color: AppColors.borderLight),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              icon: Icon(
                                link.type == 'doc' ? Icons.description_rounded : Icons.play_circle_fill_rounded,
                                size: 16,
                                color: link.type == 'doc' ? AppColors.cyan : AppColors.redLaravel,
                              ),
                              label: Text(
                                'مشاهدة الدرس: ${link.title}',
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
              ],

              // Two columns: Today's High Priority Tasks & Today's Habits
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // High Priority Tasks
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.bgSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.checklist_rounded, color: AppColors.blueFlutter, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'مهام الـ To-Do لليوم',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () => widget.onNavigateToTab(2),
                                child: const Text('عرض الكل', style: TextStyle(color: AppColors.cyan, fontSize: 12)),
                              ),
                            ],
                          ),
                          const Divider(color: AppColors.borderLight),
                          if (widget.tasks.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('لا توجد مهام حالياً. يمكنك إضافة مهام من تبويب To-Do.'),
                            )
                          else
                            ...widget.tasks.take(4).map((task) => CheckboxListTile(
                                  value: task.isCompleted,
                                  activeColor: AppColors.emeraldGreen,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    task.title,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: task.isCompleted ? AppColors.textMuted : AppColors.textPrimary,
                                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                  subtitle: Text(
                                    task.categoryArabicName,
                                    style: TextStyle(fontSize: 11, color: task.categoryColor),
                                  ),
                                  onChanged: (val) {
                                    widget.onToggleTask(task);
                                  },
                                )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Today's Daily Habits
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.bgSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.check_box_outlined, color: AppColors.emeraldGreen, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'الالتزام اليومي (صلاة، صحة، مذاكرة)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () => widget.onNavigateToTab(4),
                                child: const Text('عرض الكل', style: TextStyle(color: AppColors.cyan, fontSize: 12)),
                              ),
                            ],
                          ),
                          const Divider(color: AppColors.borderLight),
                          ...widget.habits.take(5).map((habit) => CheckboxListTile(
                                value: habit.isCompleted,
                                activeColor: AppColors.emeraldGreen,
                                contentPadding: EdgeInsets.zero,
                                secondary: Icon(habit.icon, color: habit.color, size: 20),
                                title: Text(
                                  habit.title,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: habit.isCompleted ? AppColors.textMuted : AppColors.textPrimary,
                                    decoration: habit.isCompleted ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                subtitle: Text(
                                  habit.subtitle,
                                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                                ),
                                onChanged: (val) {
                                  widget.onToggleHabit(habit);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required double progress,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              InkWell(
                onTap: onAction,
                child: Row(
                  children: [
                    Text(
                      actionLabel,
                      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.chevron_left_rounded, size: 16, color: color),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: AppColors.bgSurfaceLight,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
