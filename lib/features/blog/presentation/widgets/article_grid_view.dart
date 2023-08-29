import 'package:flutter/material.dart';

import '../../domain/entities/article.dart';

class ArticleGridView extends StatelessWidget {
  final Article article;
  const ArticleGridView({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
        Column(
          children: [
            Image(
              image: NetworkImage(article.image?? ""),
              width: 200,
              height: 160,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0 , left: 8),
              child: Text(
                article.title,
                style: const TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0 , left: 8),
              child: Text(
                article.subTitle,
                style: const TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            
          ],
        ),
    );
  }
}