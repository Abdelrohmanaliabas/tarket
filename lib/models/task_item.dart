import 'package:flutter/material.dart';

enum TaskCategory {
  study,     // مذاكرة برمجية (4 ساعات)
  practice,  // تطبيق عملي وكود (1 ساعة)
  spiritual, // صلاة وعبادات
  health,    // رياضة وتغذية
  general,   // مهام عامة
}

enum TaskPriority {
  low,
  medium,
  high,
}

class TaskItem {
  final String id;
  String title;
  String description;
  TaskCategory category;
  TaskPriority priority;
  bool isCompleted;
  DateTime createdAt;
  DateTime? dueDate;

  TaskItem({
    required this.id,
    required this.title,
    this.description = '',
    required this.category,
    this.priority = TaskPriority.medium,
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category.name,
        'priority': priority.name,
        'isCompleted': isCompleted,
        'createdAt': createdAt.toIso8601String(),
        'dueDate': dueDate?.toIso8601String(),
      };

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String? ?? '',
        category: TaskCategory.values.firstWhere(
          (e) => e.name == json['category'],
          orElse: () => TaskCategory.general,
        ),
        priority: TaskPriority.values.firstWhere(
          (e) => e.name == json['priority'],
          orElse: () => TaskPriority.medium,
        ),
        isCompleted: json['isCompleted'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
        dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      );

  String get categoryArabicName {
    switch (category) {
      case TaskCategory.study:
        return 'مذاكرة برمجية (4س)';
      case TaskCategory.practice:
        return 'تطبيق عملي (1س)';
      case TaskCategory.spiritual:
        return 'صلاة وعبادة';
      case TaskCategory.health:
        return 'صحة وتمرين';
      case TaskCategory.general:
        return 'مهام شخصية';
    }
  }

  IconData get categoryIcon {
    switch (category) {
      case TaskCategory.study:
        return Icons.menu_book_rounded;
      case TaskCategory.practice:
        return Icons.code_rounded;
      case TaskCategory.spiritual:
        return Icons.mosque_rounded;
      case TaskCategory.health:
        return Icons.fitness_center_rounded;
      case TaskCategory.general:
        return Icons.task_alt_rounded;
    }
  }

  Color get categoryColor {
    switch (category) {
      case TaskCategory.study:
        return const Color(0xFF06B6D4); // Cyan
      case TaskCategory.practice:
        return const Color(0xFF8B5CF6); // Violet
      case TaskCategory.spiritual:
        return const Color(0xFF10B981); // Emerald
      case TaskCategory.health:
        return const Color(0xFFF59E0B); // Amber
      case TaskCategory.general:
        return const Color(0xFF3B82F6); // Blue
    }
  }

  Color get priorityColor {
    switch (priority) {
      case TaskPriority.high:
        return const Color(0xFFEF4444);
      case TaskPriority.medium:
        return const Color(0xFFF59E0B);
      case TaskPriority.low:
        return const Color(0xFF10B981);
    }
  }

  String get priorityArabicName {
    switch (priority) {
      case TaskPriority.high:
        return 'أولوية قصوى';
      case TaskPriority.medium:
        return 'أولوية متوسطة';
      case TaskPriority.low:
        return 'أولوية عادية';
    }
  }
}
