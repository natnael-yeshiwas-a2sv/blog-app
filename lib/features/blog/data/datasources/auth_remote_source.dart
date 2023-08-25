import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/data/models/dto/get_profile_dto.dart';
import 'package:blog_application/features/blog/data/models/dto/login_response_dto.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, LoginResponseDto>> login(
      {required String email, required String password});
  Future<Either<Failure, void>> register(String email, String password,
      [String? bio, String? fullName, String? expertise]);
  Future<Either<Failure, GetProfileDto>> getProfile();
  void setToken(String? fold);
}
