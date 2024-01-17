class ExamModel {
  final String id;
  final String title;
  final String description;
  final int duration;

  ExamModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
  });

  factory ExamModel.fromMap( map, String id) {
    return ExamModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'duration': duration,
    };
  }
}
