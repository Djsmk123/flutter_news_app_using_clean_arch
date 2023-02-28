import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/news_entities.dart';

class NewsContainer extends StatelessWidget {
  final News news;
  const NewsContainer({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5,),
          Text(news.title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          if(news.urlToImage!=null)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Image.network(news.urlToImage!,fit: BoxFit.cover,),
                ],
              ),
            ),
          Text(news.description??"No Description provided",style: const TextStyle(fontSize: 14),),

          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(news.author??"Unknown",maxLines:1,style: const TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,)),

              Flexible(child: Text(formatDate(parseDate(news.publishedAt)),style: const TextStyle(fontSize: 12),)),
            ],
          ),
        ],
      )
    );
  }
  DateTime parseDate(String input) {
    try {
      return DateTime.parse(input);
    } catch (e) {
      return DateTime.now();
    }
  }
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
