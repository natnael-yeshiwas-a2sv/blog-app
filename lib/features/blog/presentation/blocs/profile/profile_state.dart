part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  final User user;
  final List<Article> articles;
  File? file;
  ProfileState({required this.user, required this.articles, this.file});
  @override
  List<Object?> get props => [user, articles];
}

final class ProfileInitial extends ProfileState {
  ProfileInitial({required super.user, required super.articles, super.file});
}

class ProfileLoading extends ProfileState {
  ProfileLoading({required super.user, required super.articles, super.file});
 
}

class ProfileFailed extends ProfileState {
  ProfileFailed({required super.user, required super.articles, super.file});
  
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded({required super.user, required super.articles, super.file});
}
class ProfileUploading extends ProfileState {
  ProfileUploading({required super.user, required super.articles, super.file});
}
class ProfileUploaded extends ProfileState {
  ProfileUploaded({required super.user, required super.articles, super.file});
}
class ProfileUploadFailed extends ProfileState {
  ProfileUploadFailed({required super.user, required super.articles, super.file});
}
class ArticleDeleted extends ProfileState {
  ArticleDeleted({required super.user, required super.articles, super.file});
}


