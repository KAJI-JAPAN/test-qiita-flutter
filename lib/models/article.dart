import 'package:qiita_api_test_app/models/user.dart';

class Article {
  Article({
    required this.title,
    required this.user,
    this.likesCount = 0,
    this.tags = const [],
    required this.createdAt,
    required this.url,
  });

  final String title;
  final User user;
  final int likesCount;
  final List<String> tags;
  final DateTime createdAt;
  final String url;

  factory Article.fromjson(dynamic json) {
    return Article(
      title: json['title'] as String,
      user: User.fromJson(json['user']),
      url: json['url'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likesCount: json['likes_count'] as int,
      tags: List<String>.from(json['tags'].map((tag) => tag['name'])),
    );
  }
}
