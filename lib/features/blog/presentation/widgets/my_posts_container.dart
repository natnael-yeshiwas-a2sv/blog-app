import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'article_grid_view.dart';
import 'my_post_card.dart';

class MyPostsContainer extends StatefulWidget {
  final List<Article> articles;
  final void Function(String id) onDelete;

  MyPostsContainer({Key? key, required this.articles, required this.onDelete})
      : super(key: key);

  @override
  State<MyPostsContainer> createState() => _MyPostsContainerState();
}

class _MyPostsContainerState extends State<MyPostsContainer> {
  bool selected = false;

  Widget buildGridView() {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemCount: widget.articles.length,
        itemBuilder: (BuildContext context, int index) {
          return ArticleGridView(article: widget.articles[index]);
        },
      ),
    );
  }

  Widget buildListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.articles.length,
        itemBuilder: (context, index) {
          String title = widget.articles[index].title;
          if (widget.articles[index].title.length > 25) {
            title = "${widget.articles[index].title.substring(0, 25)}...";
          }
          String subtitle = widget.articles[index].subTitle;
          if (widget.articles[index].subTitle.length > 80) {
            subtitle = "${widget.articles[index].subTitle.substring(0, 80)}...";
          }
          return MyPostCard(
            title: title,
            subtitle: subtitle,
            date: widget.articles[index].createdAt ?? DateTime.now(),
            onClick: () {
              Navigator.pushNamed(
                context,
                BlogAppRoutes.ARTICLE_EDIT,
                arguments: widget.articles[index],
              );
            },
            imageUrl: widget.articles[index].image,
            onDelete: () {
              
              widget.onDelete(widget.articles[index].id);
            },
          );
        },
      ),
    );
  }

  void onSelected(bool value) {
    setState(() {
      selected = value;
    });
  }

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
    Widget myCard = widget.articles.isEmpty
        ? Column(children: [
            Center(child: Text("You've No Post")),
          ])
        : selected
            ? buildListView()
            : buildGridView();


    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        width: 375,
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
                IconButton(
                  icon: const Icon(
                    Icons.grid_view,
                    size: 25,
                  ),
                  color: !selected ? Color(0xFF386BED) : Colors.black,
                  onPressed: () => onSelected(false),
                ),
                const SizedBox(
                  width: 10,
                ),
IconButton(
                  icon: const Icon(
                    Icons.format_list_bulleted,
                    size: 25,
                  ),
                  color: !selected ? Colors.black : Color(0xFF386BED),
                  onPressed: () => onSelected(true),
                ),

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            myCard,
          ],
        ),
      ),
    );
  }

}

}

