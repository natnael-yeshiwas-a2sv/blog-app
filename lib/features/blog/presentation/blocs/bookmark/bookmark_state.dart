part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final bool isBookmarked;

  BookmarkState(this.isBookmarked);

  @override
  List<Object?> get props => [isBookmarked];
}
