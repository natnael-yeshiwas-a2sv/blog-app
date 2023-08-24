part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProfileFailed extends ProfileState {
  final String error;
  ProfileFailed(this.error);
  @override
  List<Object?> get props => [error];
}

class ProfileLoaded extends ProfileState {
  final User user;
  final List<Article> articles;
  ProfileLoaded({required this.user, required this.articles});
  @override
  List<Object?> get props => throw UnimplementedError();
}
