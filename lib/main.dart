import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/habit_item.dart';
import 'models/task_item.dart';
import 'screens/curriculum_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/habits_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/todo_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  runApp(const TarketApp());
}

class TarketApp extends StatelessWidget {
  const TarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تاركت | Tarket Dev Roadmap',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedTabIndex = 0;
  List<TaskItem> _tasks = [];
  List<HabitItem> _habits = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final tasks = await StorageService.loadTasks();
    final habits = await StorageService.loadTodayHabits();
    setState(() {
      _tasks = tasks;
      _habits = habits;
      _isLoading = false;
    });
  }

  void _handleAddTask(TaskItem task) async {
    setState(() {
      _tasks.insert(0, task);
    });
    await StorageService.saveTasks(_tasks);
  }

  void _handleToggleTask(TaskItem task) async {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
    await StorageService.saveTasks(_tasks);
  }

  void _handleDeleteTask(String taskId) async {
    setState(() {
      _tasks.removeWhere((t) => t.id == taskId);
    });
    await StorageService.saveTasks(_tasks);
  }

  void _handleToggleHabit(HabitItem habit) async {
    setState(() {
      habit.isCompleted = !habit.isCompleted;
    });
    await StorageService.saveTodayHabits(_habits);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.bgDark,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.cyan),
        ),
      );
    }

    final screens = [
      DashboardScreen(
        tasks: _tasks,
        habits: _habits,
        onNavigateToTab: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        onToggleTask: _handleToggleTask,
        onToggleHabit: _handleToggleHabit,
        onAddTask: _handleAddTask,
      ),
      CurriculumScreen(
        onAddTaskToTodo: _handleAddTask,
        onDayStatusChanged: () {
          setState(() {});
        },
      ),
      TodoScreen(
        tasks: _tasks,
        onAddTask: _handleAddTask,
        onToggleTask: _handleToggleTask,
        onDeleteTask: _handleDeleteTask,
      ),
      const TimerScreen(),
      HabitsScreen(
        habits: _habits,
        onToggleHabit: _handleToggleHabit,
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.bgDark,
        body: Row(
          children: [
            // Right Modern Navigation Rail (Sidebar for Arabic RTL)
            Container(
              width: 240,
              decoration: const BoxDecoration(
                color: AppColors.bgSurface,
                border: Border(
                  left: BorderSide(color: AppColors.borderLight, width: 0.8),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // App Branding Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyan.withValues(alpha: 0.3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
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
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تاركت | Tarket',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Flutter & Laravel Roadmap',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: AppColors.borderLight),
                  const SizedBox(height: 10),

                  // Nav Items
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        _buildNavItem(
                          icon: Icons.dashboard_rounded,
                          title: 'لوحة التحكم',
                          index: 0,
                          badge: null,
                        ),
                        _buildNavItem(
                          icon: Icons.school_rounded,
                          title: 'جدول المذاكرة (4س + 1س)',
                          index: 1,
                          badge: '30 يوم',
                        ),
                        _buildNavItem(
                          icon: Icons.checklist_rtl_rounded,
                          title: 'قائمة المهام (To-Do)',
                          index: 2,
                          badge: '${_tasks.where((t) => !t.isCompleted).length}',
                        ),
                        _buildNavItem(
                          icon: Icons.timer_rounded,
                          title: 'مؤقت التركيز والراحة',
                          index: 3,
                          badge: null,
                        ),
                        _buildNavItem(
                          icon: Icons.check_box_rounded,
                          title: 'الالتزام والعادات اليومية',
                          index: 4,
                          badge: '${_habits.where((h) => !h.isCompleted).length}',
                        ),
                      ],
                    ),
                  ),

                  // Bottom Version & Target Indicator (Footer)
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.bgSurfaceLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyan.withValues(alpha: 0.25),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
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
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الهدف: Mid-Level',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                            Text(
                              'Full-Stack Developer',
                              style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: IndexedStack(
                index: _selectedTabIndex,
                children: screens,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
    String? badge,
  }) {
    final isSelected = _selectedTabIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.cyan.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? Border.all(color: AppColors.cyan.withOpacity(0.4)) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? AppColors.cyan : AppColors.textMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColors.cyan : AppColors.textSecondary,
                  ),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.cyan : AppColors.bgSurfaceLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.textMuted,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
