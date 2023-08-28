class MutateArticleResponse {
  bool? success;
  Date? date;

  MutateArticleResponse({this.success, this.date});

  MutateArticleResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (date != null) {
      data['date'] = date!.toJson();
    }
    return data;
  }
}

class Date {
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

  Date(
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

  Date.fromJson(Map<String, dynamic> json) {
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