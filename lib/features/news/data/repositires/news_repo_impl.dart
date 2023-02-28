import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/errors/failure/failures.dart';
import 'package:news_app_clean_architecture/core/network/network.dart';
import 'package:news_app_clean_architecture/features/news/data/datasources/news_remote_data_source.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/news_entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/repositories/news_repo.dart';

import '../../../../core/errors/exceptions/exceptions.dart';

class NewsRepoImpl extends NewsRepo{
  final NewsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepoImpl({required this.remoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, List<News>>> getNews() async{
    return await _fetchNews(() => remoteDataSource.getNews());
  }

  @override
  Future<Either<Failure, List<News>>> searchNews({required String query})async {
    return await _fetchNews(() => remoteDataSource.searchNews(query: query));
  }

  Future<Either<Failure, List<News>>> _fetchNews(
    Function fetchNews,
      )async{
    if(await networkInfo.isConnected){
      try{
        final remoteNews = await fetchNews();
        return Right(remoteNews);
      }on ServerException catch(e){
        return Left(ServerFailure(message: e.message));
      }
    }
    else{
      return Left(InternetFailure());
    }

  }

}