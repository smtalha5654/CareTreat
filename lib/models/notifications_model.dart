class NotificationModel {
  final String title;
  final String body;

  NotificationModel({
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}
