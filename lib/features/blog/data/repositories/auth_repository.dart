import 'dart:io';

import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/data/datasources/auth_remote_source.dart';
import 'package:blog_application/features/blog/data/datasources/local_datasource.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/domain/entities/user.dart';
import 'package:blog_application/features/blog/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  LocalDataSource localDataSource;
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(
      {required this.localDataSource, required this.authRemoteDataSource}) {
    final user = localDataSource.getCachedUser();

    authRemoteDataSource.setToken(user.fold((l) => '', (r) => r.token));
  }

  @override
  Future<User> getCurrentUser() {
    final user = localDataSource.getCachedUser();
    return user.fold((l) {
      return Future.value(const User(email: '', id: '', fullName: '', bio: '', expertise: ''));
    }, (r) {
      User user = User(
        bio: r.data?.bio,
        email: r.data?.email ?? '',
        fullName: r.data?.fullName,
        expertise: r.data?.expertise,
        id: r.data?.id ?? '',
        image: r.data?.image,
      );
      return Future.value(user);
    });
  }

  @override
  bool isLoggedIn() {
    final user = localDataSource.getCachedUser();
    return user.isRight();
  }

  @override
  Future<Either<Failure, void>> login(String email, String password) {
    final loginResponse =
        authRemoteDataSource.login(email: email, password: password);
    return loginResponse.then((value) => value.fold((l) => Left(l), (r) {
          localDataSource.cacheUser(r);
          authRemoteDataSource.setToken(r.token);
          return const Right(unit);
        }));
  }

  @override
  Future<void> logout() async {
    localDataSource.clearUserCache();
  }

  @override
  Future<Either<Failure, void>> register(String email, String password,
      [String? bio, String? fullName, String? expertise]) {
    final registerResponse = authRemoteDataSource.register(
        email, password, bio, fullName, expertise);
    return registerResponse.then((value) => value.fold((l) => Left(l), (r) {
          return const Right(unit);
        }));
  }

  @override
  Future<Either<Failure, Tuple2<User, List<Article>>>> getProfile() async {
    final getProfileResponse = await authRemoteDataSource.getProfile();
    return getProfileResponse.fold((l) => Left(l), (r) async {
      final user = User(
        bio: r.data?.bio,
        email: r.data?.email ?? '',
        fullName: r.data?.fullName,
        expertise: r.data?.expertise,
        id: r.data?.id ?? '',
        image: r.data?.image,
      );
      var articles = r.data?.articles ?? [];
      var articlesDomain = articles.map((e) async {
        var isArticleBookmarked = await localDataSource
            .getCachedBookmarkedArticles()
            .then((value) => value.fold((l) => false, (r) => r.contains(e.id)));
        return Article(
          id: e.id ?? '',
          title: e.title ?? '',
          content: e.content ?? '',
          tags: e.tags ?? [],
          user: user,
          subTitle: e.subTitle ?? '',
          estimatedReadTime: e.estimatedReadTime ?? '',
          image: e.image ?? '',
          isArticleBookmarked: isArticleBookmarked,
          createdAt: DateTime.parse(e.createdAt ?? ''),
        );
      }).toList();
      var articlesD = await Future.wait(articlesDomain);
      return Right(Tuple2(user, articlesD));
    });
  }
  @override
  Future<Either<Failure, String>> updateProfile(File image){
    return authRemoteDataSource.updateProfile(image);
  }
}
