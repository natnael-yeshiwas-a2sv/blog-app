part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class LoadAllArticles extends ArticleEvent {
  final String searchparams;
  final String selectedTag;

  const LoadAllArticles({
    required this.searchparams,
    required this.selectedTag,
   });

  @override
  List<Object> get props => [searchparams, selectedTag];
}

class LoadArticlesAndTags extends ArticleEvent {
  final String searchparams;
  final List<String> tags;

  const LoadArticlesAndTags({
    required this.searchparams,
    required this.tags,
   });

  @override
  List<Object> get props => [searchparams, tags];
}

class LoadAllTags extends ArticleEvent {
  final String searchparams;
  const LoadAllTags(
    this.searchparams,
  );

  @override
  List<Object> get props => [searchparams];
}

