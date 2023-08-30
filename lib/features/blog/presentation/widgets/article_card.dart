import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String tag;
  final String imageUrl;
  const ArticleCard({
    required this.title,
    required this.author,
    required this.date,
    required this.tag,
    super.key,
    required this.imageUrl,
  });
  bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388,
      height: 240,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: ShapeDecoration(
        color: isDarkMode(context) == false
            ? Colors.white
            : const Color.fromARGB(255, 52, 57, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color.fromARGB(179, 230, 229, 229),
            blurRadius: isDarkMode(context) ? 0 : 8,
            offset: isDarkMode(context) ? Offset(0, 0) : Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0),
                      child: Image(
                        image: NetworkImage(imageUrl),
                        width: 200,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: Container(
                        width: 76,
                        height: 26,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '5 min read',
                            style: TextStyle(
                              color: Color(0xFF414141),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.white
                              : Color(0xFF4D4A49),
                          fontSize: 15,
                          fontFamily: GoogleFonts.urbanist().fontFamily,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.36,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 71,
                      height: 21,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF5D5E6F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "by $author",
                      style: TextStyle(
                        color: isDarkMode(context)
                            ? Colors.white
                            : Color(0xFF4D4A49),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              date,
              style: const TextStyle(
                color: Color(0xFF7D7D7D),
                fontSize: 12,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
