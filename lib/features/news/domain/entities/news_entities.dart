import 'package:equatable/equatable.dart';

class News extends Equatable{
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String? content;
  final String publishedAt;
  final String? author;

  const News({
    required this.title,
     required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.author,
    required this.publishedAt,
  });

  @override
  List<Object> get props => [
        title,
        description!,
        url,
         author!,
        urlToImage!,
        content!,
        publishedAt,
      ];
}