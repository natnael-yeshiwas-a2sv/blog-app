import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/exceptions/Failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

class GetArticles extends UseCase<List<Article>, GetArticlesParam> {
  final ArticleRepository repository;

  GetArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(GetArticlesParam params) async {
    return await repository.getArticles(tags: params.tags , searchParams: params.searchParams);
  }
}

class GetArticlesParam extends Equatable{

  final List<String>? tags;
  final String? searchParams;
  const GetArticlesParam({this.tags, this.searchParams});
  @override
  // TODO: implement props
  List<Object?> get props =>[tags,searchParams];

}