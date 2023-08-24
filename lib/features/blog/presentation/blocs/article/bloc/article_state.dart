part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  const ArticleState();
  
  @override
  List<Object> get props => [];
}

final class ArticleInitial extends ArticleState {}
final class ArticleLoading extends ArticleState {}
final class TagsLoading extends ArticleState {}
final class ArticlesLoaded extends ArticleState {
  final List<Article> articles;

  const ArticlesLoaded({
    required this.articles,
  });

  @override
  List<Object> get props => [articles];
}

final class TagsLoaded extends ArticleState {
  final List<String> tags;

  const TagsLoaded({
    required this.tags,
  });

  @override
  List<Object> get props => [tags];
}

final class ArticleError extends ArticleState {
  final String message;

  const ArticleError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class TagsError extends ArticleState {
  final String message;

  const TagsError({
    required this.message,
  });

  @override
  List<Object> get props => [message,];
}
