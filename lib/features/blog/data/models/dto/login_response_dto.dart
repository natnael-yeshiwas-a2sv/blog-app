class LoginResponseDto {
  bool? success;
  Data? data;
  String? token;

  LoginResponseDto({this.success, this.data, this.token});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  String? sId;
  String? fullName;
  String? email;
  String? password;
  String? expertise;
  String? bio;
  String? createdAt;
  int? iV;
  String? image;
  String? imageCloudinaryPublicId;
  String? id;

  Data(
      {this.sId,
        this.fullName,
        this.email,
        this.password,
        this.expertise,
        this.bio,
        this.createdAt,
        this.iV,
        this.image,
        this.imageCloudinaryPublicId,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    expertise = json['expertise'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    image = json['image'];
    imageCloudinaryPublicId = json['imageCloudinaryPublicId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['expertise'] = expertise;
    data['bio'] = bio;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['image'] = image;
    data['imageCloudinaryPublicId'] = imageCloudinaryPublicId;
    data['id'] = id;
    return data;
  }
}
