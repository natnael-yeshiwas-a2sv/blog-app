import 'dart:convert';
import 'dart:io';

import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/data/datasources/article_api_resources.dart';
import 'package:blog_application/features/blog/data/models/dto/get_articles_dto.dart';
import 'package:blog_application/features/blog/data/models/dto/get_tags_dto.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
      File? image}) async {
    try {
      var urlString = base_url + "article";
      var url = Uri.parse(urlString);
      print(url.toString());
      var response = http.MultipartRequest('POST', url);
      response.headers.addAll({
        "AUTHORIZATION": "Bearer $token",
        "Content-type": "multipart/form-data"
      });
      response.fields['title'] = title;
      response.fields['content'] = content;
      response.fields['subTitle'] = subTitle;
      if (estimatedReadTime != null) {
        response.fields['estimatedReadTime'] = estimatedReadTime;
      }
      if (tags.isNotEmpty) {
        response.fields['tags'] = tags.first;
      }
      var headers = {'Content-Type': 'image/jpeg'};
      if (image != null) {
        print("hello from this");

        // ...
        var ext = image.path.split('.').last;
        print(ext);
        response.files.add(await http.MultipartFile.fromPath(
          'photo',
          image.path,
          contentType: MediaType('image', 'jpeg'),
        ));
        print(response.files.length);
      }

      var res = await response.send();
      if (res.statusCode == 200) {
        return Right(Article(
          content: content,
          id: "",
          image: "",
          subTitle: subTitle,
          tags: tags,
          title: title,
          estimatedReadTime: estimatedReadTime ?? "",
          createdAt: DateTime.now(),
        ));
      }
      print(res.statusCode);
      return Left(ServerFailure(message: 'message'));
    } catch (e) {
      print(e);
      return Left(NetworkFailure(message: 'message'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteArticle(String id) async {
    try {
      var urlString = base_url + "article" + "/$id";
      var url = Uri.parse(urlString);
      print(url.toString());
      var response =
          await client.delete(url, headers: {"AUTHORIZATION": "Bearer $token"});
      print(response.body);
      if (response.statusCode == 200) {
        print("deleted successfully");
        return Right(unit);
      } else {
        return const Left(ServerFailure(message: 'Server Failure'));
      }
    } catch (e) {
      return const Left(NetworkFailure(message: 'Server Failure'));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getArticles(
      {List<String>? tags, String? searchParams}) async {
    try {
      var urlString =
          "${base_url}article${tags != null && tags.isNotEmpty ? "?tags=${tags.join(',')}" : ""}${searchParams != null && searchParams.isNotEmpty ? "?searchParams=$searchParams" : ""}";

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
    } catch (e) {
      return const Left(NetworkFailure(message: 'Server Failure'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getTags() async {
    try {
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
    } catch (e) {
      return const Left(NetworkFailure(message: 'Server Failure'));
    }
  }

  @override
  Future<Either<Failure, Article>> updateArticle(
      {required String id,
      required String title,
      required String content,
      required List<String> tags,
      required String subTitle,
      String? estimatedReadTime,
      File? image}) async {
    try {
      var urlString = base_url + "article" + "/$id";
      var url = Uri.parse(urlString);
      print(url.toString());
      var response = http.MultipartRequest('PUT', url);
      response.headers.addAll({
        "AUTHORIZATION": "Bearer $token",
        "Content-type": "multipart/form-data"
      });
      response.fields['title'] = title;
      response.fields['content'] = content;
      response.fields['subTitle'] = subTitle;
      if (estimatedReadTime != null) {
        response.fields['estimatedReadTime'] = estimatedReadTime;
      }
      if (tags.isNotEmpty) {
        response.fields['tags'] = tags.first;
      }
      var headers = {'Content-Type': 'image/jpeg'};
      if (image != null) {
        print("hello from this");

        // ...
        var ext = image.path.split('.').last;
        print(ext);
        response.files.add(await http.MultipartFile.fromPath(
          'photo',
          image.path,
          contentType: MediaType('image', 'jpeg'),
        ));
        print(response.files.length);
      }

      var res = await response.send();
      if (res.statusCode == 200) {
        return Right(Article(
          content: content,
          id: "",
          image: "",
          subTitle: subTitle,
          tags: tags,
          title: title,
          estimatedReadTime: estimatedReadTime ?? "",
          createdAt: DateTime.now(),
        ));
      }
      print(res.statusCode);
      return Left(ServerFailure(message: 'message'));
    } catch (e) {
      print(e);
      return Left(NetworkFailure(message: 'message'));
    }
  }

  setToken(String? fold) {
    token = fold ?? '';
  }
}
