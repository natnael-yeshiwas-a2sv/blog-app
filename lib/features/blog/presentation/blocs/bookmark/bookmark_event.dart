part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleBookmarkEvent extends BookmarkEvent {
  String id;
  ToggleBookmarkEvent({required this.id});
}

class IsBookmarkedEvent extends BookmarkEvent {
  String id;
  IsBookmarkedEvent({required this.id});
}
