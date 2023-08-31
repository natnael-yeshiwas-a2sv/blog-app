import 'dart:convert';
import 'dart:io';

import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/data/datasources/auth_remote_source.dart';
import 'package:blog_application/features/blog/data/models/dto/get_profile_dto.dart';
import 'package:blog_application/features/blog/data/models/dto/login_response_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String base_url;
  String token;

  AuthRemoteDataSourceImpl(
      {required this.client,
      this.base_url = "https://blog-api-4z3m.onrender.com/api/v1/",
      this.token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ZTY0YTFhNTdmNjZkNzVlOGJiNzMxMyIsImlhdCI6MTY5MjgxNDQ0MywiZXhwIjoxNjk1NDA2NDQzfQ.5owvXykhKJnvrwe-MvJnk1Z5aM_neuOpZVYS4f1_vUI"});

  @override
  Future<Either<Failure, LoginResponseDto>> login(
      {required String email, required String password}) async {
    try {
      var urlString = "${base_url}user/login";
      var url = Uri.parse(urlString);
      var response =
          await client.post(url, body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        var loginResponseDto = LoginResponseDto.fromJson(data);

        return Right(loginResponseDto);
      } else {
        var data = await jsonDecode(response.body);
        return Left(ServerFailure(message: data["error"]));
      }
    } catch (e) {
      return const Left(NetworkFailure(message: "Connection Error :)"));
    }
  }

  @override
  Future<Either<Failure, void>> register(String email, String password,
      [String? bio, String? fullName, String? expertise]) async {

    try {
      var urlString = "${base_url}user";
      var url = Uri.parse(urlString);
      var response = await client.post(url, body: {
        'email': email,
        'password': password,
        'fullName': fullName ?? '',
        'bio': bio ?? '',
        'expertise': expertise ?? ''
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return const Right(unit);
      } else {
        var data = await jsonDecode(response.body);
        return Left(ServerFailure(message: data["error"]));
      }
    } catch (e) {
      return const Left(NetworkFailure(message: "Connection Error :)"));

    }
  }

  @override
  Future<Either<Failure, GetProfileDto>> getProfile() async {

    try {
      final urlString = "${base_url}user";
      final url = Uri.parse(urlString);


      final response =
          await client.get(url, headers: {"AUTHORIZATION": "Bearer $token"});
      if (response.statusCode == 200) {
        print(response.body);


        var data = jsonDecode(response.body);
        var getProfileDto = GetProfileDto.fromJson(data);
        return Right(getProfileDto);
      } else {
        var data = await jsonDecode(response.body);
        return Left(ServerFailure(message: data["error"]));
      }
    } catch (e) {
      return Left(NetworkFailure(message: e.toString()));

    }
  }

  @override
  void setToken(String? fold) {
    token = fold ?? '';
  }
  
  @override
  Future<Either<Failure, String>> updateProfile(File image) async {
    try{
      var urlString = "${base_url}user/update/image";
      var url = Uri.parse(urlString);
      var response = http.MultipartRequest('PUT', url);
      response.headers.addAll({
        "AUTHORIZATION": "Bearer $token",
        "Content-type": "multipart/form-data"
      });
      response.files.add(await http.MultipartFile.fromPath(
        'photo',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      ));
      print(response.files.length);
    
      var res = await response.send();
      if (res.statusCode == 200) {
        print("wow uploaded successfully");
        return const Right("Succesffully Uploaded");

      }
      print(res.statusCode);
      return const Left(ServerFailure(message: 'message'));
    } catch (e) {
      print(e);
      return const Left(NetworkFailure(message: 'message'));
    }
  }
}
