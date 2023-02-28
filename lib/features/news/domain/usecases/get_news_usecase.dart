import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/news_entities.dart';

import '../../../../core/errors/failure/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/news_repo.dart';

class GetNews extends UseCase<List<News>, NoParams> {
  final NewsRepo repository;

  GetNews(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(NoParams params) async {
    return await repository.getNews();
  }
}