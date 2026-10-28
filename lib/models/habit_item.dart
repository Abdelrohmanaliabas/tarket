import 'package:flutter/material.dart';

class HabitItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  bool isCompleted;
  final String categoryKey; // prayer, study, health, general

  HabitItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isCompleted = false,
    required this.categoryKey,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'iconCode': icon.codePoint,
        'colorValue': color.toARGB32(),
        'isCompleted': isCompleted,
        'categoryKey': categoryKey,
      };

  factory HabitItem.fromJson(Map<String, dynamic> json) => HabitItem(
        id: json['id'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        icon: IconData(json['iconCode'] as int, fontFamily: 'MaterialIcons'),
        color: Color(json['colorValue'] as int),
        isCompleted: json['isCompleted'] as bool? ?? false,
        categoryKey: json['categoryKey'] as String,
      );
}
