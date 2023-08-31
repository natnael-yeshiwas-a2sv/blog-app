import 'package:blog_application/features/blog/domain/repositories/article_repository.dart';

class GetBookMarkedArticleUseCase {
  final ArticleRepository repository;
  GetBookMarkedArticleUseCase(this.repository);

  Future<bool> call(String id) async {
    return repository.isArticleBookmarked(id);
  }
}
