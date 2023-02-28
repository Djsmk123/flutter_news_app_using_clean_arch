
import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/news_entities.dart';

import '../../../../core/errors/failure/failures.dart';

abstract class NewsRepo {
  Future<Either<Failure, List<News>>> getNews();
  Future<Either<Failure, List<News>>> searchNews({required String query});
}