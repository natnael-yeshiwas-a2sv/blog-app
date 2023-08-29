import 'package:blog_application/features/blog/domain/repositories/article_repository.dart';
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
  ArticleRepository articleRepository;
  ProfileBloc(
    this.getProfileUseCase,
    this.articleRepository,
  ) : super(ProfileInitial(articles: [], user: User(id: "", email: ""))) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading(articles: [], user: User(id: "", email: "")));
      final profile = await getProfileUseCase(NoParam());
      print("hellp");
      print(profile);
      profile.fold((l)=> {
        emit(ProfileFailed(articles: [], user: User(id: "", email: "")))
      }, (r)=> {
        emit(ProfileLoaded(
          user: r.value1,
          articles: r.value2,
        ))
      });
    });
    on<DeleteArticleEvent>((event, emit) async{
      final articles = state.articles;
      final article = articles.where((element) => element.id == event.id);
      final filteredArticle = articles.where((element) => element.id != event.id).toList();
      emit(ProfileLoaded(user: state.user, articles: filteredArticle));
      final req = await articleRepository.deleteArticle(event.id);
      req.fold((l) => ProfileLoaded(user: state.user, articles: [...articles]), (r) => ProfileLoaded(articles: filteredArticle, user: state.user));
    });
  }

  
}
