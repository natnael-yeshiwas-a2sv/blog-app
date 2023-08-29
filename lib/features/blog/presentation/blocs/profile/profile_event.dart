part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {}

class GetProfileEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class DeleteArticleEvent extends ProfileEvent {
  final String id;
  DeleteArticleEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class UploadProfilePic extends ProfileEvent {
  final File image;
  UploadProfilePic({required this.image});
  @override
  List<Object?> get props => [image];
}