part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class LoadAllArticles extends ArticleEvent {
  final String searchparams;
  final List<String> tags;

  const LoadAllArticles({
    required this.searchparams,
    required this.tags,
   });

  @override
  List<Object> get props => [searchparams, tags];
}

class LoadAllTags extends ArticleEvent {
  const LoadAllTags();

  @override
  List<Object> get props => [];
}

