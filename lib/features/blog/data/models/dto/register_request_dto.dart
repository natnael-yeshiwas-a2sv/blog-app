class RegisterRequestDto {
  String? bio;
  String? fullName;
  String? email;
  int? password;
  String? expertise;

  RegisterRequestDto(
      {this.bio, this.fullName, this.email, this.password, this.expertise});

  RegisterRequestDto.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    expertise = json['expertise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bio'] = bio;
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['expertise'] = expertise;
    return data;
  }
}