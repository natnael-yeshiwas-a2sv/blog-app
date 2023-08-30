import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleReadingTitle extends StatefulWidget {
  final String title;
  const ArticleReadingTitle({
    super.key,
    required this.title,
  });

  @override
  _ArticleReadingTitleState createState() => _ArticleReadingTitleState();
}

bool isDarkMode(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  return brightness == Brightness.dark;
}

class _ArticleReadingTitleState extends State<ArticleReadingTitle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 303,
      child: Text(
        widget.title,
        style: TextStyle(
          color: isDarkMode(context)
              ? Theme.of(context).colorScheme.primary
              : Color(0xFF0D253C),
          fontSize: 24,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
