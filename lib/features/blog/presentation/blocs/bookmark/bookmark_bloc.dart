import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_application/features/blog/domain/usecases/bookmark_article.dart';
import 'package:blog_application/features/blog/domain/usecases/get_bookmarked.dart';
import 'package:equatable/equatable.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  GetBookMarkedArticleUseCase getBookMarkedArticleUseCase;
  BookMarkArticleUseCase bookMarkArticleUseCase;
  BookmarkBloc(
      {required this.getBookMarkedArticleUseCase,
      required this.bookMarkArticleUseCase})
      : super(BookmarkState(false)) {
    on<ToggleBookmarkEvent>(_onBookmark);
    on<IsBookmarkedEvent>(_onIsBookmarked);
  }

  FutureOr<void> _onIsBookmarked(
      IsBookmarkedEvent event, Emitter<BookmarkState> emit) async {
    var res = await getBookMarkedArticleUseCase(event.id);
    emit(BookmarkState(res));
  }

  FutureOr<void> _onBookmark(
      ToggleBookmarkEvent event, Emitter<BookmarkState> emit) async {
    var res = await bookMarkArticleUseCase(event.id);
    add(IsBookmarkedEvent(id: event.id));
  }
}
