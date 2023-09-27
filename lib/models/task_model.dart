class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String status;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      status: json['status'] ?? '',
    );
  }
}
