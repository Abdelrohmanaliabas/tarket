import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import '../models/habit_item.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class HabitsScreen extends StatefulWidget {
  final List<HabitItem> habits;
  final Function(HabitItem) onToggleHabit;

  const HabitsScreen({
    super.key,
    required this.habits,
    required this.onToggleHabit,
  });

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  int _streak = 1;

  @override
  void initState() {
    super.initState();
    _loadStreak();
  }

  Future<void> _loadStreak() async {
    final s = await StorageService.getStreak();
    setState(() {
      _streak = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = widget.habits.where((h) => h.isCompleted).length;
    final totalCount = widget.habits.length;
    final ratio = totalCount > 0 ? (completedCount / totalCount) : 0.0;

    // Group habits by category
    final prayerHabits = widget.habits.where((h) => h.categoryKey == 'prayer').toList();
    final studyHabits = widget.habits.where((h) => h.categoryKey == 'study').toList();
    final healthHabits = widget.habits.where((h) => h.categoryKey == 'health').toList();

    final todayFormatted = DateFormat('EEEE, d MMMM yyyy', 'ar').format(DateTime.now());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'متابعة الالتزام والعادات اليومية',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'الصلوات، الأكل، التمرين، وساعات البرمجة - $todayFormatted',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  // Streak Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: AppColors.laravelGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.redLaravel.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 24),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'سلسلة الالتزام',
                              style: TextStyle(fontSize: 11, color: Colors.white70),
                            ),
                            Text(
                              '$_streak أيام متتالية',
                              style: const TextStyle(
                                fontSize: 14,
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
              const SizedBox(height: 20),

              // Overview Banner
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: AppColors.cardGradient,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: ratio,
                            strokeWidth: 6,
                            backgroundColor: AppColors.bgSurfaceLight,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.emeraldGreen),
                          ),
                          Center(
                            child: Text(
                              '${(ratio * 100).toInt()}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.emeraldGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ratio == 1.0
                                ? '🎉 يوم أسطوري! أنجزت كافة التزاماتك اليومية 100%'
                                : 'التزام اليوم: $completedCount من أصل $totalCount التزام',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ratio >= 0.7
                                ? 'أداء رائع جداً، استمر على هذا المنوال للوصول لهدفك!'
                                : 'الانضباط اليومي في الصلاة والصحة هو سر نجاحك كمطور محترف.',
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Grouped Habits in Scrollable view
              Expanded(
                child: ListView(
                  children: [
                    // Prayer Section
                    _buildSectionHeader(
                      title: 'الصلوات الخمس والعبادات',
                      subtitle: 'الصلة بربك وبركة الوقت',
                      icon: Icons.mosque_rounded,
                      color: AppColors.cyan,
                    ),
                    ...prayerHabits.map((h) => _buildHabitCard(h)),
                    const SizedBox(height: 18),

                    // Study & Coding Section
                    _buildSectionHeader(
                      title: 'المذاكرة والتطبيق العملي (4س + 1س)',
                      subtitle: 'الاستثمار البرمجي اليومي',
                      icon: Icons.code_rounded,
                      color: AppColors.blueFlutter,
                    ),
                    ...studyHabits.map((h) => _buildHabitCard(h)),
                    const SizedBox(height: 18),

                    // Health & Lifestyle Section
                    _buildSectionHeader(
                      title: 'الصحة، الأكل والتمرين',
                      subtitle: 'جسمك هو أداة تركيزك',
                      icon: Icons.fitness_center_rounded,
                      color: AppColors.amberOrange,
                    ),
                    ...healthHabits.map((h) => _buildHabitCard(h)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(HabitItem habit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: habit.isCompleted ? AppColors.emeraldGreen.withOpacity(0.5) : AppColors.borderLight,
          width: habit.isCompleted ? 1.4 : 0.8,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: habit.isCompleted ? AppColors.emeraldGreen.withOpacity(0.2) : habit.color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            habit.icon,
            color: habit.isCompleted ? AppColors.emeraldGreen : habit.color,
            size: 22,
          ),
        ),
        title: Text(
          habit.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: habit.isCompleted ? AppColors.emeraldGreen : AppColors.textPrimary,
            decoration: habit.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          habit.subtitle,
          style: TextStyle(
            fontSize: 12,
            color: habit.isCompleted ? AppColors.textMuted : AppColors.textSecondary,
          ),
        ),
        trailing: Transform.scale(
          scale: 1.25,
          child: Checkbox(
            value: habit.isCompleted,
            activeColor: AppColors.emeraldGreen,
            onChanged: (val) {
              widget.onToggleHabit(habit);
            },
          ),
        ),
      ),
    );
  }
}
