import 'get_articles_dto.dart';

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
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    image = json['image'];
    imageCloudinaryPublicId = json['imageCloudinaryPublicId'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tags'] = tags;
    data['content'] = content;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['estimatedReadTime'] = estimatedReadTime;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['image'] = image;
    data['imageCloudinaryPublicId'] = imageCloudinaryPublicId;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}