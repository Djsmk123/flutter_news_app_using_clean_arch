import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/core/errors/failure/failures.dart';
import 'package:news_app_clean_architecture/core/usecase/use_case.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/news_entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/repositories/news_repo.dart';

class GetSearchedNews extends UseCase<List<News>, Params> {
  final NewsRepo repository;
  GetSearchedNews(this.repository);
  @override
  Future<Either<Failure, List<News>>> call(Params params) async {
    return await repository.searchNews(query: params.query);
  }
}

class Params extends Equatable{
  final String query;

  const Params({required this.query});

  @override
  List<Object?> get props => [query];
}