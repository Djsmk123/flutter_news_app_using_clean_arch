import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/errors/failure/failures.dart';
import 'package:news_app_clean_architecture/core/usecase/use_case.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/news_entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_searched_news_usecase.dart';

import '../../domain/usecases/get_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNews;
  final GetSearchedNews searchNews;
  NewsBloc({
    required this.getNews,
    required this.searchNews,
}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is GetNewsEvent) {
        emit(NewsLoading());
        final result= await getNews(NoParams());
        dispatchEvent(emit,result);
      } else if (event is SearchNewsEvent) {
        emit(NewsLoading());
        final result= await searchNews(Params(query: event.query));
        dispatchEvent(emit,result);
      }
    });
  }
  Future<void> dispatchEvent(Emitter emit,result) async {
    result.fold((l) {
      emit(NewsError(message: _mapError(l)));
    }, (r) {
      if (r.isEmpty) {
        emit(NewsEmpty());
      } else {
        emit(NewsLoaded(newsList: r));
      }
    });
  }
  _mapError(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is InternetFailure) {
        return 'No internet connection';
    } else {
      return const NewsError(message: 'Unexpected error');
    }
  }
}
