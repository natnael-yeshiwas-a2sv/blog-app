import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleApiResource {
  Future<Either<Failure, List<Article>>> getArticles(
      {List<String>? tags, String? searchParams});
  Future<Either<Failure, List<String>>> getTags();
  Future<Either<Failure, Article>> createArticle(
      {required String title,
      required String content,
      required List<String> tags,
      required String subTitle,
      String? estimatedReadTime,
      String? image});
  Future<Either<Failure, Article>> updateArticle(Article article);
  Future<Either<Failure, void>> deleteArticle(String id);
  void setToken(String? fold);
}
