import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_post_card.dart';

class MyPostsContainer extends StatelessWidget {
  List<Article> articles;
  MyPostsContainer({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    Widget myPost = Container();
    if(articles.isEmpty){
      myPost = Column(children:[Center(child: Text("You've No Post"),)]);
    } else {
      myPost =Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return MyPostCard(
                    title: articles[index].title,
                    subtitle: articles[index].subTitle,
                  );
                },
              ),
            );

    }
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        width: 375,
        height: 345,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x115182FF),
              blurRadius: 32,
              offset: Offset(0, -25),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
             Row(
              children: [
                Text(
                  'My Posts',
                  style: TextStyle(
                    color:const Color(0xFF0D253C),
                    fontSize: 20,
                    fontFamily: GoogleFonts.urbanist().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 150,
                ),
                const Icon(
                  Icons.grid_view,
                  size: 25,
                  color: Color(0xFF386BED),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.format_list_bulleted,
                  color: Color.fromARGB(255, 106, 125, 173),
                  size: 25,
                
                )
              ],              
            ),
            myPost
          ],
        ),
      ),
    );
  }
}

