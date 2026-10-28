import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_item.dart';
import '../models/habit_item.dart';

class StorageService {
  static const String _tasksKey = 'tarket_tasks_list';
  static const String _completedDaysKey = 'tarket_completed_days';
  static const String _currentStreakKey = 'tarket_current_streak';
  static const String _studySecondsTodayKey = 'tarket_study_seconds_';

  // Load Tasks
  static Future<List<TaskItem>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString(_tasksKey);

    if (tasksJson != null && tasksJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(tasksJson);
        return decoded.map((item) => TaskItem.fromJson(item as Map<String, dynamic>)).toList();
      } catch (e) {
        debugPrint('Error loading tasks: $e');
      }
    }

    // Default starter tasks if first time
    return _getDefaultStarterTasks();
  }

  // Save Tasks
  static Future<void> saveTasks(List<TaskItem> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await prefs.setString(_tasksKey, encoded);
  }

  // Load Completed Curriculum Days
  static Future<Set<int>> loadCompletedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? list = prefs.getStringList(_completedDaysKey);
    if (list != null) {
      return list.map((e) => int.tryParse(e) ?? 0).where((e) => e > 0).toSet();
    }
    return {};
  }

  // Save Completed Curriculum Days
  static Future<void> saveCompletedDays(Set<int> days) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_completedDaysKey, days.map((e) => e.toString()).toList());
  }

  // Load Habits for Today
  static Future<List<HabitItem>> loadTodayHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = 'tarket_habits_${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
    final String? habitsJson = prefs.getString(todayKey);

    final defaultList = _getDefaultHabits();

    if (habitsJson != null && habitsJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(habitsJson);
        final Map<String, bool> statusMap = {};
        for (var item in decoded) {
          statusMap[item['id']] = item['isCompleted'] ?? false;
        }

        for (var habit in defaultList) {
          if (statusMap.containsKey(habit.id)) {
            habit.isCompleted = statusMap[habit.id]!;
          }
        }
      } catch (e) {
        debugPrint('Error loading habits: $e');
      }
    }

    return defaultList;
  }

  // Save Habits for Today
  static Future<void> saveTodayHabits(List<HabitItem> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = 'tarket_habits_${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
    final encoded = jsonEncode(habits.map((h) => h.toJson()).toList());
    await prefs.setString(todayKey, encoded);
  }

  // Load & Save Streak
  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_currentStreakKey) ?? 1;
  }

  static Future<void> incrementStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_currentStreakKey) ?? 1;
    await prefs.setInt(_currentStreakKey, current + 1);
  }

  // Study Seconds Tracker
  static Future<int> getStudySecondsToday() async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_studySecondsTodayKey${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
    return prefs.getInt(key) ?? 0;
  }

  static Future<void> addStudySecondsToday(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_studySecondsTodayKey${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
    final current = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, current + seconds);
  }

  // Default initial tasks
  static List<TaskItem> _getDefaultStarterTasks() {
    return [
      TaskItem(
        id: '1',
        title: 'مذاكرة اليوم 1: كيف يعمل الكمبيوتر والإنترنت والبرمجة',
        description: 'إتمام 4 ساعات مذاكرة مركزة وفهم النظام الثنائي والمترجم والمنطق.',
        category: TaskCategory.study,
        priority: TaskPriority.high,
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      TaskItem(
        id: '2',
        title: 'ساعة التطبيق العملي: رسم مخطط التدفق (Flowchart)',
        description: 'رسم خريطة تدفق لعملية تسجيل الدخول وحسابات الآلة الحاسبة.',
        category: TaskCategory.practice,
        priority: TaskPriority.high,
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      TaskItem(
        id: '3',
        title: 'أداء صلاة الظهر والعصر في المسجد/وقتها',
        description: 'المحافظة على الصلاة في جماعة وراحة ذهنية.',
        category: TaskCategory.spiritual,
        priority: TaskPriority.high,
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      TaskItem(
        id: '4',
        title: 'تمرين بدني ونصف ساعة مشي وتمدد',
        description: 'تنشيط الدورة الدموية ومقاومة آلام الجلوس الطويل أمام الشاشة.',
        category: TaskCategory.health,
        priority: TaskPriority.medium,
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
    ];
  }

  // Default Daily Habits
  static List<HabitItem> _getDefaultHabits() {
    return [
      HabitItem(
        id: 'habit_fajr',
        title: 'صلاة الفجر',
        subtitle: 'في أول وقتها وقراءة أذكار الصباح',
        icon: Icons.brightness_3_rounded,
        color: const Color(0xFF06B6D4),
        categoryKey: 'prayer',
      ),
      HabitItem(
        id: 'habit_dhuhr',
        title: 'صلاة الظهر',
        subtitle: 'المحافظة على صلاة الظهر في وقتها',
        icon: Icons.wb_sunny_rounded,
        color: const Color(0xFF38BDF8),
        categoryKey: 'prayer',
      ),
      HabitItem(
        id: 'habit_asr',
        title: 'صلاة العصر',
        subtitle: 'الصلاة الوسطى والذكر',
        icon: Icons.filter_drama_rounded,
        color: const Color(0xFFF59E0B),
        categoryKey: 'prayer',
      ),
      HabitItem(
        id: 'habit_maghrib',
        title: 'صلاة المغرب',
        subtitle: 'في وقتها وأذكار المساء',
        icon: Icons.nights_stay_outlined,
        color: const Color(0xFFF97316),
        categoryKey: 'prayer',
      ),
      HabitItem(
        id: 'habit_isha',
        title: 'صلاة العشاء والوتر',
        subtitle: 'ختام الصلوات وركعة الوتر',
        icon: Icons.bedtime_rounded,
        color: const Color(0xFF8B5CF6),
        categoryKey: 'prayer',
      ),
      HabitItem(
        id: 'habit_study',
        title: '4 ساعات مذاكرة مركزة',
        subtitle: 'دون تشتت أو سوشيال ميديا',
        icon: Icons.menu_book_rounded,
        color: const Color(0xFF0284C7),
        categoryKey: 'study',
      ),
      HabitItem(
        id: 'habit_practice',
        title: 'ساعة التطبيق العملي والكود',
        subtitle: 'كتابة وممارسة الأكواد عملياً',
        icon: Icons.code_rounded,
        color: const Color(0xFF10B981),
        categoryKey: 'study',
      ),
      HabitItem(
        id: 'habit_workout',
        title: 'تمرين رياضي / نشاط بدني',
        subtitle: '30-45 دقيقة لصحة الظهر والنشاط',
        icon: Icons.fitness_center_rounded,
        color: const Color(0xFFEC4899),
        categoryKey: 'health',
      ),
      HabitItem(
        id: 'habit_water_food',
        title: 'أكل صحي وشرب 3 لتر ماء',
        subtitle: 'ترطيب مستمر وتغذية تدعم التركيز',
        icon: Icons.restaurant_rounded,
        color: const Color(0xFF14B8A6),
        categoryKey: 'health',
      ),
      HabitItem(
        id: 'habit_sleep',
        title: 'نوم صحي مبكر (7-8 ساعات)',
        subtitle: 'شحن الطاقة الذهنية ليوم جديد',
        icon: Icons.nightlight_round,
        color: const Color(0xFF6366F1),
        categoryKey: 'health',
      ),
    ];
  }
}
