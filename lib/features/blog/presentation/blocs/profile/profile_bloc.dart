import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/domain/entities/user.dart';
import 'package:blog_application/features/blog/domain/usecases/get_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfile getProfileUseCase;
  ProfileBloc(
    this.getProfileUseCase
  ) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final profile = await getProfileUseCase(NoParam());
      print("hellp");
      print(profile);
      profile.fold((l)=> {
        emit(ProfileFailed("Loading Profile Error"))
      }, (r)=> {
        emit(ProfileLoaded(
          user: r.value1,
          articles: r.value2,
        ))
      });
    });
  }

  
}
