import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    this.bio,
    this.fullName,
    this.expertise,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  final String id;
  final String email;
  final String? bio;
  final String? fullName;
  final String? expertise;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['bio'] = bio;
    data['email'] = email;
    data['expertise'] = expertise;
    data['fullName'] = fullName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['image'] = image;
    return data;
  }
  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        bio = json['bio'],
        email = json['email'],
        expertise = json['expertise'],
        fullName = json['fullName'],
        createdAt = json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt = json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        image = json['image'];
  @override
  List<Object?> get props => [id, email, bio, fullName, expertise, createdAt, updatedAt];
}