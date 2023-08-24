import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/article.dart';
import '../../../../domain/usecases/get_articles.dart';
import '../../../../domain/usecases/get_tags.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  final GetArticles getArticles;
  final GetTags getTags;
  
  ArticleBloc(
    this.getArticles,
    this.getTags,
  ) : super(ArticleInitial()) {
    on<ArticleEvent>((event, emit) {});
    on<LoadAllArticles>(_onLoadAllArticles);
    on<LoadAllTags>(_onLoadAllTags);
  }
  void _onLoadAllArticles(LoadAllArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    final result = await getArticles(GetArticlesParam(tags: event.tags,
                                        searchParams: event.searchparams,));
    
    result.fold((l) => emit(ArticleError(message: l.message)), (r) => emit(ArticlesLoaded(articles: r)));
  }

  void _onLoadAllTags(LoadAllTags event, Emitter<ArticleState> emit) async {
    emit(TagsLoading());
    final result = await getTags(NoParams());
    result.fold((l) => emit(TagsError(message: l.message)), (r) => emit(TagsLoaded(tags: r)));
  }
}
