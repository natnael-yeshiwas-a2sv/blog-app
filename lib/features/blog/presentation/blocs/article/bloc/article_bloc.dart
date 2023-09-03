import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/article.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/usecases/get_articles.dart';
import '../../../../domain/usecases/get_current_user.dart';
import '../../../../domain/usecases/get_tags.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticles getArticles;
  final GetTags getTags;
  final GetCurrentUser getCurrentUser;

  ArticleBloc({
    required this.getArticles,
    required this.getTags,
    required this.getCurrentUser,
  }) : super(const ArticleInitial([], [])) {
    on<ArticleEvent>((event, emit) {});
    on<LoadArticlesAndTags>(_onLoadAllArticlesAndTags);
    on<LoadAllArticles>(_onLoadAllArticles);
  }
  void _onLoadAllArticlesAndTags(
      LoadArticlesAndTags event, Emitter<ArticleState> emit) async {
    emit(ArticleAndTagLoading(state.selectedTags, const []));

    final result = await getArticles(GetArticlesParam(
      tags: event.tags,
      searchParams: event.searchparams,
    ));

    print(result);

    final tags = await getTags(NoParams());
    final user = await getCurrentUser(NoParams());

    result.fold(
      (l) => emit(
        ArticleAndTagError(
          message: l.message,
          selectedTags: state.selectedTags,
          tags: state.selectedTags,
        ),
      ),
      (r) => emit(
        ArticlesAndTagLoaded(
            articles: r,
            tags: tags.fold((l) => [], (r) => r),
            selectedTags: const <String>[],
            user: user),
      ),
    );
  }

  void _onLoadAllArticles(
      LoadAllArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleAndTagLoading(state.selectedTags, state.tags));
    var selectedTags = [...state.selectedTags];
    if (state.selectedTags.contains(event.selectedTag)) {
      selectedTags.remove(event.selectedTag);
    } else if (event.selectedTag.isNotEmpty) {
      selectedTags.add(event.selectedTag);
    }
    emit(ArticleAndTagLoading(selectedTags, state.tags));

    final result = await getArticles(GetArticlesParam(
      tags: state.selectedTags,
      searchParams: event.searchparams,
    ));
    final user = await getCurrentUser(NoParams());

    result.fold(
      (l) => emit(
        ArticleAndTagError(
          message: l.message,
          selectedTags: state.selectedTags,
          tags: state.tags,
        ),
      ),
      (r) => emit(
        ArticlesAndTagLoaded(
          articles: r,
          selectedTags: state.selectedTags,
          tags: state.tags,
          user: user,
        ),
      ),
    );
    // print("$state natnael tafesseeeeeeeeeeeee");
  }
}
