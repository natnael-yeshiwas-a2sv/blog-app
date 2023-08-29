import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/data/models/dto/login_response_dto.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class LocalDataSource {
  Future<Either<Failure, void>> cacheTags(List<String> tags);
  Future<Either<Failure, List<String>>> getCachedTags();
  Future<Either<Failure, void>> cacheArticles(List<Article> articles);
  Future<Either<Failure, List<Article>>> getCachedArticles();
  Future<Either<Failure, void>> cacheUser(LoginResponseDto user);
  Either<Failure, LoginResponseDto> getCachedUser();
  Future<void> clearUserCache();
  Future<Either<Failure, void>> bookMarkArticle(String id);
  Future<Either<Failure, List<String>>> getCachedBookmarkedArticles();
}
