import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/article.dart';
import '../../../../domain/usecases/get_articles.dart';
import '../../../../domain/usecases/get_tags.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  final GetArticles getArticles;
  final GetTags getTags;
  
  ArticleBloc({
    required this.getArticles,
    required this.getTags,
  }) : super(const ArticleInitial([], [])) {
    on<ArticleEvent>((event, emit) {});
    on<LoadArticlesAndTags>(_onLoadAllArticlesAndTags);
    on<LoadAllArticles>(_onLoadAllArticles);
  }
  
  void _onLoadAllArticlesAndTags(LoadArticlesAndTags event, Emitter<ArticleState> emit) async {
    emit(ArticleAndTagLoading(state.selectedTags,const []));
    final result = await getArticles(GetArticlesParam(tags: event.tags,
                                        searchParams: event.searchparams,));
                                        
    final tags = await getTags(NoParams());
    
    result.fold((l) => emit(ArticleAndTagError(message: l.message)), (r) => emit(ArticlesAndTagLoaded(articles: r, 
                        tags: tags.fold((l) => [], (r) => r),
                        selectedTags:const <String>[],)));
  }

  void _onLoadAllArticles(LoadAllArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleAndTagLoading(state.selectedTags, state.tags));
    var selectedTags = [...state.selectedTags];
    if(state.selectedTags.contains(event.selectedTag)){

      selectedTags.remove(event.selectedTag);
    }else if (event.selectedTag.isNotEmpty){
      selectedTags.add(event.selectedTag);
    }
    emit(ArticleAndTagLoading(selectedTags, state.tags));

    final result = await getArticles(GetArticlesParam(tags: state.selectedTags,
                                        searchParams: event.searchparams,));
    result.fold((l) => emit(ArticleAndTagError(message: l.message)), (r) => emit(ArticlesAndTagLoaded(articles: r,
                        selectedTags: state.selectedTags, tags:state.tags )));
  }
}
