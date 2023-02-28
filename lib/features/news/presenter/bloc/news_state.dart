part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}
class NewsLoaded extends NewsState {
  final List<News> newsList;
  const NewsLoaded({required this.newsList});
  @override
  List<Object> get props => [newsList];
}
class NewsError extends NewsState {
  final String message;
  const NewsError({required this.message});
  @override
  List<Object> get props => [message];
}
class NewsEmpty extends NewsState {
  @override
  List<Object> get props => [];
}
