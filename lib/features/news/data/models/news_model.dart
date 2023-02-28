import '../../domain/entities/news_entities.dart';

class NewsModel extends News{
  const NewsModel({required super.title, required super.description, required super.url, required super.urlToImage, required super.content, required super.publishedAt, required super.author});
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      publishedAt: json['publishedAt'], author:json['author'] ?? 'No Author',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
      'publishedAt': publishedAt,
      'author': author ?? 'No Author',
    };
  }
}
