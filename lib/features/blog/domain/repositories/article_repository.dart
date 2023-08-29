import 'dart:io';

import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/article.dart';
abstract class ArticleRepository {
  Future<Either<Failure,Article>> getArticle(String id);
  Future<Either<Failure,List<Article>>> getArticles({List<String>? tags, String? searchParams});
  Future<Either<Failure,List<String>>> getTags();
  Future<Either<Failure,Article>> createArticle({required String title, required String content, required List<String> tags, required String subTitle, String? estimatedReadTime, File? image});
  Future<Either<Failure,Article>> updateArticle({required String id,required String title, required String content, required List<String> tags, required String subTitle, String? estimatedReadTime, File? image});
  Future<Either<Failure,void>> deleteArticle(String id);
  Future<Either<Failure,void>> bookmarkArticle(String id);
  Future<Either<Failure,void>> unBookmarkArticle(String id);
  Future<bool> isArticleBookmarked(String id);
}