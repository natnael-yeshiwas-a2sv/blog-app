import 'dart:io';

import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';
abstract class AuthRepository {
  Future<Either<Failure,void>> login(String email, String password);
  Future<void> logout();
  Future<Either<Failure,void>> register(String email, String password, [String? bio, String? fullName, String? expertise]);
  bool isLoggedIn();
  Future<User> getCurrentUser();
  Future<Either<Failure, Tuple2<User, List<Article>>>>  getProfile();
  Future<Either<Failure, String>> updateProfile(File image);
}