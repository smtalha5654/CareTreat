class NotificationModel {
  final String title;
  final String body;
  final DateTime createdAt; // Add timestamp property

  NotificationModel({
    required this.title,
    required this.body,
    required this.createdAt, // Include timestamp in the constructor
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'createdAt': createdAt.toUtc().toIso8601String(), // Convert DateTime to string
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''), // Parse string to DateTime
    );
  }
}