import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/domain/entities/user.dart';

class GetArticlesResponseDto {
  bool? success;
  List<ArticleModel>? data;

  GetArticlesResponseDto({this.success, this.data});

  GetArticlesResponseDto.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ArticleModel>[];
      json['data'].forEach((v) {
        data!.add(new ArticleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticleModel {
  String? sId;
  List<String>? tags;
  String? content;
  String? title;
  String? subTitle;
  String? estimatedReadTime;
  UserModel? user;
  String? image;
  String? imageCloudinaryPublicId;
  String? createdAt;
  int? iV;
  String? id;

  ArticleModel(
      {this.sId,
        this.tags,
        this.content,
        this.title,
        this.subTitle,
        this.estimatedReadTime,
        this.user,
        this.image,
        this.imageCloudinaryPublicId,
        this.createdAt,
        this.iV,
        this.id});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tags = json['tags'].cast<String>();
    content = json['content'];
    title = json['title'];
    subTitle = json['subTitle'];
    estimatedReadTime = json['estimatedReadTime'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    image = json['image'];
    imageCloudinaryPublicId = json['imageCloudinaryPublicId'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['tags'] = this.tags;
    data['content'] = this.content;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['estimatedReadTime'] = this.estimatedReadTime;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['image'] = this.image;
    data['imageCloudinaryPublicId'] = this.imageCloudinaryPublicId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
  Article toDomain(){
    return Article(
      id: id ?? '',
      content: content ?? '',
      title: title ?? '',
      subTitle: subTitle ?? '',
      estimatedReadTime: estimatedReadTime ?? '',
      image: image ?? '',
      tags: tags ?? [],
      user: user?.toDomain(),
      createdAt: DateTime.parse(createdAt ?? ''),
    );
  }
  @override
  String toString() {
    return 'ArticleModel{sId: $sId, tags: $tags, content: $content, title: $title, subTitle: $subTitle, estimatedReadTime: $estimatedReadTime, user: $user, image: $image, imageCloudinaryPublicId: $imageCloudinaryPublicId, createdAt: $createdAt, iV: $iV, id: $id}';
  }
}

class UserModel {
  String? sId;
  String? fullName;
  String? email;
  String? expertise;
  String? bio;
  String? createdAt;
  int? iV;
  String? image;
  String? imageCloudinaryPublicId;
  String? id;

  UserModel(
      {this.sId,
        this.fullName,
        this.email,
        this.expertise,
        this.bio,
        this.createdAt,
        this.iV,
        this.image,
        this.imageCloudinaryPublicId,
        this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    expertise = json['expertise'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    image = json['image'];
    imageCloudinaryPublicId = json['imageCloudinaryPublicId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['expertise'] = this.expertise;
    data['bio'] = this.bio;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['image'] = this.image;
    data['imageCloudinaryPublicId'] = this.imageCloudinaryPublicId;
    data['id'] = this.id;
    return data;
  }
  User toDomain(){
    return User(
      id: id ?? '',
      bio: bio ?? '',
      email: email ?? '',
      expertise: expertise ?? '',
      fullName: fullName ?? '',
      image: image ?? '',
    );
  }
  @override
  String toString() {
    return 'UserModel{sId: $sId, fullName: $fullName, email: $email, expertise: $expertise, bio: $bio, createdAt: $createdAt, iV: $iV, image: $image, imageCloudinaryPublicId: $imageCloudinaryPublicId, id: $id}';
  }
}

