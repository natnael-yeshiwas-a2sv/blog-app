import 'package:blog_application/features/blog/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  Article(
      {required this.id,
      required this.title,
      required this.content,
      required this.tags,
      this.createdAt,
      required this.subTitle,
      required this.estimatedReadTime,
      required this.image,
      this.isArticleBookmarked= false,
      this.user});

  final String id;
  final String title;
  final String subTitle;
  final String estimatedReadTime;
  final String image;
  final User? user;
  final String content;
  final List<String> tags;
  final DateTime? createdAt;
  bool? isArticleBookmarked;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['tags'] = tags;
    data['content'] = content;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['estimatedReadTime'] = estimatedReadTime;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['image'] = image;
    data['createdAt'] = createdAt;
    return data;
  }

  Article.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        tags = json['tags'].cast<String>(),
        content = json['content'],
        title = json['title'],
        subTitle = json['subTitle'],
        estimatedReadTime = json['estimatedReadTime'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        image = json['image'],
        createdAt = json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null;
  @override
  List<Object?> get props => [
        id,
        title,
        content,
        tags,
        createdAt,
        subTitle,
        estimatedReadTime,
        image,
        user
      ];
}
