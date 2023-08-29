part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  final User user;
  final List<Article> articles;
  ProfileState({required this.user, required this.articles});
  @override
  List<Object?> get props => [user, articles];
}

final class ProfileInitial extends ProfileState {
  ProfileInitial({required super.user, required super.articles});
}

class ProfileLoading extends ProfileState {
  ProfileLoading({required super.user, required super.articles});
 
}

class ProfileFailed extends ProfileState {
  ProfileFailed({required super.user, required super.articles});
  
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded({required super.user, required super.articles});
  
}
