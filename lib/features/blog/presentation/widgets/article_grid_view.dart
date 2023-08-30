import 'package:flutter/material.dart';

import '../../domain/entities/article.dart';

class ArticleGridView extends StatelessWidget {
  final Article article;
  const ArticleGridView({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    String title = article.title;
    if(article.title.length > 15){
      title = "${article.title.substring(0,15)}...";}
     return Container(
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        // color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 8,
            offset: Offset(-4, -4),
            spreadRadius: 4,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // padding: EdgeInsets.only(bottom:50),
        child: Expanded(
          child: Image(
            width: 200,
            image: NetworkImage(article.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
          const SizedBox(height: 20),
          Text(
            "$title",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          
        ],
      ),
      );
  }
}