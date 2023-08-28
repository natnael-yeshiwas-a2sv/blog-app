import 'package:blog_application/features/blog/data/datasources/article_api_resources.dart';
import 'package:blog_application/features/blog/data/datasources/article_api_resources_impl.dart';
import 'package:blog_application/features/blog/data/datasources/auth_remote_source.dart';
import 'package:blog_application/features/blog/data/datasources/auth_remote_source_impl.dart';
import 'package:blog_application/features/blog/data/datasources/local_data_source_impl.dart';
import 'package:blog_application/features/blog/data/datasources/local_datasource.dart';
import 'package:blog_application/features/blog/data/repositories/article_repository.dart';
import 'package:blog_application/features/blog/data/repositories/auth_repository.dart';
import 'package:blog_application/features/blog/domain/repositories/article_repository.dart';
import 'package:blog_application/features/blog/domain/repositories/auth_repository.dart';
import 'package:blog_application/features/blog/domain/usecases/bookmark_article.dart';
import 'package:blog_application/features/blog/domain/usecases/get_bookmarked.dart';

import 'package:blog_application/features/blog/domain/usecases/get_profile.dart';
import 'package:blog_application/features/blog/domain/usecases/get_tags.dart';
import 'package:blog_application/features/blog/presentation/blocs/bookmark/bookmark_bloc.dart';
import 'package:blog_application/features/blog/presentation/blocs/create_task/create_task_bloc.dart';
import 'package:blog_application/features/blog/presentation/blocs/profile/profile_bloc.dart';

import 'package:blog_application/features/blog/domain/usecases/isloged_in_usecase.dart';
import 'package:blog_application/features/blog/domain/usecases/login_usecase.dart';
import 'package:blog_application/features/blog/domain/usecases/logout_usecase.dart';
import 'package:blog_application/features/blog/domain/usecases/register_usecase.dart';
import 'package:blog_application/features/blog/presentation/blocs/auth/auth_bloc.dart';
import 'package:blog_application/features/blog/domain/usecases/get_tags.dart';
import 'package:blog_application/features/blog/presentation/blocs/article/bloc/article_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blog_application/features/blog/domain/usecases/get_articles.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton(Client());
  sl.registerSingleton<LocalDataSource>(
      LocalDataSourceImpl(sharedPreferences: sharedPreferences));
  sl.registerSingleton<ArticleApiResource>(
      ArticleApiResourceImpl(client: sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(
    localDataSource: sl(),
    articleApiResourceImpl: sl(),
  ));
  sl.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(client: sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(
    authRemoteDataSource: sl(),
    localDataSource: sl(),
  ));

  sl.registerFactory(() => GetProfile(sl()));

  sl.registerFactory(() =>
    ProfileBloc(sl())
  );
  sl.registerFactory(()=> GetTags(sl()));
  sl.registerSingleton(CreateTaskCubit(getTagsUsecase: sl(), articleRepository: sl()));

  sl.registerFactory(() => IsLogedIn(sl()));
  sl.registerFactory(() => LoginUseCase(sl()));
  sl.registerFactory(() => RegisterUseCase(sl()));
  sl.registerFactory(() => Logout(sl()));

  sl.registerSingleton<AuthBloc>(AuthBloc(
    sl<LoginUseCase>(),
    sl<RegisterUseCase>(),
    sl<Logout>(),
  ));

  sl.registerSingleton(
    GetArticles(sl()),
  );

  sl.registerFactory(()=> 
    ArticleBloc(
      getArticles : sl(), 
      getTags: sl(),
      )
  );

  sl.registerFactory(() => GetBookMarkedArticleUseCase(sl()));
  sl.registerFactory(() => BookMarkArticleUseCase(sl()));
  sl.registerSingleton<BookmarkBloc>(BookmarkBloc(
      getBookMarkedArticleUseCase: sl(), bookMarkArticleUseCase: sl()));
}
