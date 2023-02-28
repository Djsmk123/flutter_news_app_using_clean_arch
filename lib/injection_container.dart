import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app_clean_architecture/core/network/network.dart';
import 'package:news_app_clean_architecture/features/news/domain/repositories/news_repo.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_news_usecase.dart';
import 'package:http/http.dart' as http;
import 'features/news/data/datasources/news_remote_data_source.dart';
import 'features/news/data/repositires/news_repo_impl.dart';
import 'features/news/domain/usecases/get_searched_news_usecase.dart';
import 'features/news/presenter/bloc/news_bloc.dart';
final sl= GetIt.instance;
Future<void> init()async{
  //Bloc
  sl.registerFactory(() => NewsBloc(
    getNews: sl(),
    searchNews: sl(),
  ));
  //UseCase
  sl.registerLazySingleton(() => GetNews(sl()));
  sl.registerLazySingleton(() => GetSearchedNews(sl()));
  //Repository
  sl.registerLazySingleton<NewsRepo>(() => NewsRepoImpl( remoteDataSource: sl(), networkInfo: sl(),));
  //Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(sl()));
  //! External

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}