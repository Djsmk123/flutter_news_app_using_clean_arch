import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/core/errors/failure/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [null];
}