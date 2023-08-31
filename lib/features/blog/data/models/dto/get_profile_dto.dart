class GetProfileDto {
  bool? success;
  Data? data;

  GetProfileDto({this.success, this.data});

  GetProfileDto.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? fullName;
  String? email;
  String? expertise;
  String? bio;
  String? createdAt;
  int? iV;
  String? image;
  String? imageCloudinaryPublicId;
  List<Articles>? articles;
  String? id;

  Data(
      {this.sId,
      this.fullName,
      this.email,
      this.expertise,
      this.bio,
      this.createdAt,
      this.iV,
      this.image,
      this.imageCloudinaryPublicId,
      this.articles,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    expertise = json['expertise'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    image = json['image'];
    imageCloudinaryPublicId = json['imageCloudinaryPublicId'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['expertise'] = expertise;
    data['bio'] = bio;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['image'] = image;
    data['imageCloudinaryPublicId'] = imageCloudinaryPublicId;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class Articles {
  String? sId;
  List<String>? tags;
  String? content;
  String? title;
  String? subTitle;
  String? estimatedReadTime;
  String? user;
  String? image;
  String? imageCloudinaryPublicId;
  String? createdAt;
  int? iV;
  String? id;

  Articles(
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

  Articles.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tags = json['tags'].cast<String>();
    content = json['content'];
    title = json['title'];
    subTitle = json['subTitle'];
    estimatedReadTime = json['estimatedReadTime'];
    user = json['user'];
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
    data['user'] = user;
    data['image'] = image;
    data['imageCloudinaryPublicId'] = imageCloudinaryPublicId;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}