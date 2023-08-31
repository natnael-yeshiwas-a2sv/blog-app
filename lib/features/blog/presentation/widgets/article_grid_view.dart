import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/util/input_converter.dart';
import '../../domain/entities/article.dart';

class ArticleGridView extends StatelessWidget {
  final Article article;
  final Null Function() onClick;
  final Future<void> Function() onDelete;

  const ArticleGridView({
    required this.article,
    required this.onClick,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // String title = article.title;
    // if (article.title.length > 50) {
    //   title = "${article.title.substring(0, 50)}...";
    // }
    return GestureDetector(
      onTap: onClick,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15.0),
              ),
              child: Image.network(
                article.image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8,
                right: 8,
              ),
              child: Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 15,
                      ),
                      Text(
                        '2.1k',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                          fontFamily: GoogleFonts.urbanist().fontFamily,
                          fontWeight: FontWeight.w500,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete_forever_outlined,
                          color: Colors.redAccent),
                      onPressed: onDelete,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:6.0),
                      child: Text(
                        InputConverter.calculatePostDate(
                            article.createdAt ?? DateTime.now()),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 12,
                          fontFamily: GoogleFonts.urbanist().fontFamily,
                          fontWeight: FontWeight.w500,
                          height: 1.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
