import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class BookMarkArticleUseCase {
  final ArticleRepository repository;
  BookMarkArticleUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return repository.bookmarkArticle(id);
  }
}
