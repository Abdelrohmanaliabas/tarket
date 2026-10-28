class LessonLink {
  final String title;
  final String url;
  final String sourceName; // e.g., 'Elzero Web School', 'Tharwat Samy', 'Laravel Docs', 'Flutter Docs'
  final String type; // 'video', 'doc', 'exercise'

  LessonLink({
    required this.title,
    required this.url,
    required this.sourceName,
    this.type = 'video',
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'url': url,
        'sourceName': sourceName,
        'type': type,
      };

  factory LessonLink.fromJson(Map<String, dynamic> json) => LessonLink(
        title: json['title'] as String,
        url: json['url'] as String,
        sourceName: json['sourceName'] as String,
        type: json['type'] as String? ?? 'video',
      );
}

class CurriculumDay {
  final int dayNumber;
  final int phaseId;
  final String phaseTitle;
  final String phaseBadge;
  final String title;
  final String description;
  final List<String> fourHourStudyGoals; // Breakdown of the 4 study hours
  final String oneHourPracticeGoal;     // 1 Hour practical coding task
  final List<LessonLink> links;
  bool isCompleted;
  String? userNotes;

  CurriculumDay({
    required this.dayNumber,
    required this.phaseId,
    required this.phaseTitle,
    required this.phaseBadge,
    required this.title,
    required this.description,
    required this.fourHourStudyGoals,
    required this.oneHourPracticeGoal,
    required this.links,
    this.isCompleted = false,
    this.userNotes,
  });

  Map<String, dynamic> toJson() => {
        'dayNumber': dayNumber,
        'isCompleted': isCompleted,
        'userNotes': userNotes,
      };
}
