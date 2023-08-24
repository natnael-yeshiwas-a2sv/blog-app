import 'dart:convert';

import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/data/datasources/article_api_resources.dart';
import 'package:blog_application/features/blog/data/models/dto/get_articles_dto.dart';
import 'package:blog_application/features/blog/data/models/dto/get_tags_dto.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ArticleApiResourceImpl implements ArticleApiResource {
  final http.Client client;
  final String base_url;
  String token;
  ArticleApiResourceImpl(
      {required this.client,
      this.base_url = "https://blog-api-4z3m.onrender.com/api/v1/",
      this.token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ZTY0YTFhNTdmNjZkNzVlOGJiNzMxMyIsImlhdCI6MTY5MjgxNDQ0MywiZXhwIjoxNjk1NDA2NDQzfQ.5owvXykhKJnvrwe-MvJnk1Z5aM_neuOpZVYS4f1_vUI"});
  @override
  Future<Either<Failure, Article>> createArticle(
      {required String title,
      required String content,
      required List<String> tags,
      required String subTitle,
      String? estimatedReadTime,
      String? image}) async {
    var urlString = base_url + "article";
    var url = Uri.parse(urlString);
    print(url.toString());
    var response = await client.post(url, body: {
      'title': title,
      'content': content,
      'tags':"${tags.join(',')}",
      'subTitle': subTitle,
      'estimatedReadTime': estimatedReadTime ?? '',
      'photo': image ?? '',
    }, headers: {
      "AUTHORIZATION": "Bearer $token"
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      var article = ArticleModel.fromJson(data).toDomain();
      return Right(article);
    } else {
      print(response.body);
      return const Left(ServerFailure(message: 'Server Failure'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteArticle(String id) {
    // TODO: implement deleteArticle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Article>>> getArticles(
      {List<String>? tags, String? searchParams}) async {
    var urlString = "${base_url}article${tags != null ? "?tags=${tags.join(',')}" : ""}${searchParams != null ? "?searchParams=$searchParams" : ""}";
    var url = Uri.parse(urlString);
    var response =
        await client.get(url, headers: {"AUTHORIZATION": "Bearer $token"});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      var get_articles_dto = GetArticlesResponseDto.fromJson(data);
      var articleslist = get_articles_dto!.data;
      var articles = articleslist!.map((e) => e.toDomain()).toList();
      print(articles);
      return Right(articles);
    } else {
      return const Left(ServerFailure(message: 'Server Failure'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getTags() async {
    var urlString = base_url + "tags";
    var url = Uri.parse(urlString);
    print(url.toString());
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var tags = GetTagsResponseDto.fromJson(data).tags ?? [];

      return Right(tags);
    } else {
      return const Left(ServerFailure(message: 'Server Failure'));
    }
  }

  @override
  Future<Either<Failure, Article>> updateArticle(Article article) {
    //
    throw UnimplementedError();
  }

  setToken(String? fold) {
    token = fold ?? '';
  }
}
