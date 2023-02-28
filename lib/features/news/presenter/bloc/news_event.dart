part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}
class GetNewsEvent extends NewsEvent {
   @override
    List<Object> get props => [];
}
class SearchNewsEvent extends NewsEvent {
  final String query;
  const SearchNewsEvent({required this.query});
  @override
  List<Object> get props => [query];
}
