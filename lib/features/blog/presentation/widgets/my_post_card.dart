import 'package:blog_application/features/blog/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';

import 'article_info.dart';

class MyPostCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final DateTime date;
  final Null Function() onClick;
  final Future<void> Function() onDelete;
  const MyPostCard(
      {required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.date,
      super.key,
      required this.onClick,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 295,
        height: 141,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0F5182FF),
              blurRadius: 15,
              offset: Offset(0, 10),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image(
            image: NetworkImage(imageUrl),
            width: 100,
            height: 105,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          ArticleInfo(
            title: title,
            subtitle: subtitle,
            date: date,
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined,
                color: Colors.redAccent),
            onPressed: onDelete,
          )
        ]),
      ),
    );
  }
}
