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
import 'package:blog_application/features/blog/domain/usecases/login_usecase.dart';
import 'package:blog_application/features/blog/domain/usecases/register_usecase.dart';
import 'package:blog_application/features/blog/presentation/blocs/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  sl.registerFactory(() => LoginUseCase(sl()));
  sl.registerFactory(() => RegisterUseCase(sl()));

  sl.registerSingleton<AuthBloc>(AuthBloc(
    sl<LoginUseCase>(),
    sl<RegisterUseCase>(),
  ));
  
}
