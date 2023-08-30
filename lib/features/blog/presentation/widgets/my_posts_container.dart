import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_post_card.dart';

class MyPostsContainer extends StatelessWidget {
  List<Article> articles;

  final void Function(String id) onDelete;
  MyPostsContainer({super.key, required this.articles, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    showDeleteDialog(String title) async {
      return await showDialog<String>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.delete_forever_outlined,color: Colors.redAccent),
                Text('Article Delete'),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("You're deleting article $title"),
                  const Text(
                      'Are you sure do you want to delete this article?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context, 'no');
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, 'yes');
                },
              ),
            ],
          );
        },
      );
    }

    Widget myPost = Container();
    if (articles.isEmpty) {
      myPost = Column(children: [
        Center(
          child: Text("You've No Post"),
        )
      ]);
    } else {
      myPost = Expanded(
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return MyPostCard(
              title: articles[index].title,
              subtitle: articles[index].subTitle,
              onClick: () {
                Navigator.pushNamed(context, BlogAppRoutes.ARTICLE_EDIT,
                    arguments: articles[index]);
              },
              imageUrl: articles[index].image,
              onDelete: () async {
                var ans = await showDeleteDialog(articles[index].title);
                if(ans == 'yes'){
                  onDelete(articles[index].id);
                }
              },
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
                    color: const Color(0xFF0D253C),
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
