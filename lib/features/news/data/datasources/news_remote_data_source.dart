import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app_clean_architecture/core/errors/utils/server_config.dart';

import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/news_model.dart';
abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews();
  Future<List<NewsModel>> searchNews({required String query});
}
class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl(this.client);
  @override
  Future<List<NewsModel>> getNews()async {

    const url="${ServerConfig.host}top-headlines?country=${ServerConfig.country}&apiKey=${ServerConfig.apiKey}";
    return await _fetchNews(url);
  }


  @override
  Future<List<NewsModel>> searchNews({required String query}) {
    final url="${ServerConfig.host}${ServerConfig.everything}?q=$query&apiKey=${ServerConfig.apiKey}";
    return _fetchNews(url);
  }
  Future<List<NewsModel>> _fetchNews(
    String url,
      )async{
    final res=await client.get(Uri.parse(url));
    log(res.body.toString());
    if(res.statusCode==200){
      final decoded=jsonDecode(res.body);
      List<NewsModel> news=[];
      for(var item in decoded['articles']){
        news.add(NewsModel.fromJson(item));
      }
      return news;
    }
    else{
      throw ServerException(message:'Error getting news');
    }
  }
}
