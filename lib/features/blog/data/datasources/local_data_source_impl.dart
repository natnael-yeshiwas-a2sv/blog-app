import 'dart:convert';

import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/data/datasources/local_datasource.dart';
import 'package:blog_application/features/blog/data/models/dto/login_response_dto.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Either<Failure, void>> cacheArticles(List<Article> articles) async {
    final jsonString = json.encode(articles);
    try {
      await sharedPreferences.setString('articles', jsonString);
      return const Right(unit);
    } catch (e) {
      return const Left(CacheFailure(message: 'Cache Failure'));
    }
  }

  @override
  Future<Either<Failure, void>> cacheTags(List<String> tags) async {
    try {
      sharedPreferences.setStringList('tags', tags);
      return const Right(unit);
    } catch (e) {
      return const Left(CacheFailure(message: 'Cache Failure'));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUser(LoginResponseDto user) async {
    final jsonString = json.encode(user);
    try {
      sharedPreferences.setString('user', jsonString);
      return const Right(unit);
    } catch (e) {
      return const Left(CacheFailure(message: 'Cache Failure'));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getCachedArticles() {
    final jsonString = sharedPreferences.getString('articles');
    if (jsonString != null) {
      final articles = List<Map<String, dynamic>>.from(json.decode(jsonString));
      return Future.value(
          Right(articles.map((e) => Article.fromJson(e)).toList()));
    } else {
      return Future.value(const Left(CacheFailure(message: 'Cache Failure')));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCachedTags() {
    final tags = sharedPreferences.getStringList('tags');
    if (tags != null) {
      return Future.value(Right(tags));
    } else {
      return Future.value(const Left(CacheFailure(message: 'Cache Failure')));
    }
  }

  @override
  Future<Either<Failure, LoginResponseDto>> getCachedUser() {
    final jsonString = sharedPreferences.getString('user');
    if (jsonString != null) {
      final user = LoginResponseDto.fromJson(json.decode(jsonString));
      return Future.value(Right(user));
    } else {
      return Future.value(const Left(CacheFailure(message: 'Cache Failure')));
    }
  }

  @override
  Future<void> clearUserCache() {
    try {
      sharedPreferences.remove('user');
      return Future.value(unit);
    } catch (e) {
      return Future.value(unit);
    }
  }

  @override
  Future<Either<Failure, void>> bookMarkArticle(String id) {
    // get list of bookmarked articles from local
    final bookmarks = sharedPreferences.getStringList('bookmarks');
    try {
      if (bookmarks != null) {
        if (bookmarks.contains(id)) {
          // if the article is already bookmarked
          // remove the article from bookmarked articles
          bookmarks.remove(id);
          sharedPreferences.setStringList('bookmarks', bookmarks);
          return Future.value(const Right(unit));
        } else {
          // if the article is not bookmarked
          // add the article to bookmarked articles
          bookmarks.add(id);
          sharedPreferences.setStringList('bookmarks', bookmarks);
          return Future.value(const Right(unit));
        }
      } else {
        // if there is no bookmarked articles
        // create a new list of bookmarked articles
        // add the article to bookmarked articles
        final bookmarks = [id];
        sharedPreferences.setStringList('bookmarks', bookmarks);
        return Future.value(const Right(unit));
      }
    } catch (e) {
      return Future.value(const Left(CacheFailure(message: 'Cache Failure')));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCachedBookmarkedArticles() {
     final bookmarks = sharedPreferences.getStringList('bookmarks');
    if (bookmarks != null) {
      return Future.value(Right(bookmarks));
    } else {
      return Future.value(const Left(CacheFailure(message: 'Cache Failure')));
    }
  }
}
