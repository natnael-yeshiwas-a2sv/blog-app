import 'dart:io';

import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/data/datasources/article_api_resources.dart';
import 'package:blog_application/features/blog/data/datasources/local_datasource.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  ArticleApiResource articleApiResourceImpl;
  LocalDataSource localDataSource;
  ArticleRepositoryImpl({required this.articleApiResourceImpl, required this.localDataSource}){
    final user = localDataSource.getCachedUser();
     articleApiResourceImpl.setToken(user.fold((l) => '', (r) => r.token));
  }
  @override
  Future<Either<Failure, void>> bookmarkArticle(String id) {
     return localDataSource.bookMarkArticle(id);
  }

  @override
  Future<Either<Failure, Article>> createArticle({required String title, required String content, required List<String> tags, required String subTitle, String? estimatedReadTime, File? image}) {
     final articleResponse = articleApiResourceImpl.createArticle(title: title, content: content, tags: tags, subTitle: subTitle, estimatedReadTime: estimatedReadTime, image: image);
     return articleResponse;
  }

  @override
  Future<Either<Failure, void>> deleteArticle(String id) {
    final articleResponse = articleApiResourceImpl.deleteArticle(id);
    return articleResponse;
  }

  @override
  Future<Either<Failure, Article>> getArticle(String id) {
    final article = localDataSource.getCachedArticles();
    return article.then((value) => value.fold((l) => Left(l), (r) {
          final article = r.firstWhere((element) => element.id == id);
          return Right(article);
        }));
  }

  @override
  Future<Either<Failure, List<Article>>> getArticles({List<String>? tags, String? searchParams}) {
    final articleResponse = articleApiResourceImpl.getArticles(tags: tags, searchParams: searchParams);
    return articleResponse;
  }

  @override
  Future<Either<Failure, List<String>>> getTags() {
    final tagsResponse = articleApiResourceImpl.getTags();
    return tagsResponse;
  }

  @override
  Future<bool> isArticleBookmarked(String id) {
    final bookmarked = localDataSource.getCachedBookmarkedArticles();
    return bookmarked.then((value) => value.fold((l) => false, (r) => r.contains(id)));
  }

  @override
  Future<Either<Failure, void>> unBookmarkArticle(String id) {
    return localDataSource.bookMarkArticle(id);
  }

  @override
  Future<Either<Failure, Article>> updateArticle({required String id,required String title, required String content, required List<String> tags, required String subTitle, String? estimatedReadTime, File? image}) {
    final articleResponse = articleApiResourceImpl.updateArticle(id:id, title: title, content: content, tags: tags, subTitle: subTitle, estimatedReadTime: estimatedReadTime, image: image);
     return articleResponse;
  }
}