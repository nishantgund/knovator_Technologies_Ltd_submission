import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int userId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String body;

  @HiveField(4)
  bool isRead;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.isRead = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'],
    userId: json['userId'],
    title: json['title'],
    body: json['body'],
    isRead: json['isRead'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body,
    'isRead': isRead,
  };
}