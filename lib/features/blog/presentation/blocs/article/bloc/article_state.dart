part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  final List<String> selectedTags;
  final List<String> tags;
  const ArticleState({
    required this.tags,
    required this.selectedTags,
  });

  @override
  List<Object> get props => [tags , selectedTags];
}

final class ArticleInitial extends ArticleState {
  const ArticleInitial(List<String> selectedtags, List<String> tags)
      : super(selectedTags: selectedtags, tags: tags);
}

final class ArticleAndTagLoading extends ArticleState {
  const ArticleAndTagLoading(
    List<String> selectedtags,
    List<String> tags,
  ) : super(selectedTags: selectedtags,
            tags: tags);
}

final class ArticlesAndTagLoaded extends ArticleState {
  final List<Article> articles;


  const ArticlesAndTagLoaded({
    selectedTags,
    required this.articles,
    required List<String> tags,
  }) : super(selectedTags: selectedTags, tags: tags);

  @override
  List<Object> get props => [articles , tags];
}

final class ArticlesLoaded extends ArticleState {
  final List<Article> articles;
  int count = 0;
  ArticlesLoaded({
    selectedTags,
    required this.articles,
    required this.count,
    tags,
  }) : super(selectedTags: selectedTags,
            tags: tags);

  @override
  List<Object> get props => [articles, count , tags];
}

final class ArticlesLoadeds extends ArticleState {
  final List<Article> articles;
  int count = 0;
  ArticlesLoadeds({
    selectedTags,
    required this.articles,
    required this.count,
    tags,
  }) : super(selectedTags: selectedTags,
  tags: tags);

  @override
  List<Object> get props => [articles, count ,tags];
}

final class ArticleAndTagError extends ArticleState {
  final String message;

  const ArticleAndTagError({
    selectedTags,
    tags,
    required this.message,
  }) : super(selectedTags: selectedTags,
       tags: tags);

  @override
  List<Object> get props => [message , tags];
}
