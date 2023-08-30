import 'package:blog_application/core/presentation/util/input_converter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final DateTime date;
  const ArticleInfo({required this.title, required this.subtitle, required this.date ,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          softWrap: true,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontFamily: GoogleFonts.urbanist().fontFamily,
            fontWeight: FontWeight.w100,
            height: 1.43,
          ),
        ),
         SizedBox(
          width: 163,
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              fontFamily: GoogleFonts.urbanist().fontFamily,
              fontWeight: FontWeight.w500,
              height: 1.43,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
         Row(
          children: [
            const Icon(
              Icons.thumb_up_alt_outlined,
              size: 15,
            ),
            Text(
              '2.1k',
              style: TextStyle(
                color:Theme.of(context).colorScheme.primary,
                fontSize: 12,
                fontFamily: GoogleFonts.urbanist().fontFamily,
                fontWeight: FontWeight.w500,
                height: 1.33,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.access_time,
              size: 15,
            ),
            Text(
              InputConverter.calculatePostDate(date),
              style: TextStyle(
                color:Theme.of(context).colorScheme.primary,
                fontSize: 12,
                fontFamily: GoogleFonts.urbanist().fontFamily,
                fontWeight: FontWeight.w500,
                height: 1.33,
              ),
            ),
            // const SizedBox(
            //   width: 20,
            // ),
            
          ],
        )
      ],
    );
  }
}
