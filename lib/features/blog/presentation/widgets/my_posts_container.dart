import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'article_grid_view.dart';
import 'my_post_card.dart';

class MyPostsContainer extends StatefulWidget {
  final List<Article> articles;
  final void Function(String id) onDelete;

  const MyPostsContainer({Key? key, required this.articles, required this.onDelete})
      : super(key: key);

  @override
  State<MyPostsContainer> createState() => _MyPostsContainerState();
}

class _MyPostsContainerState extends State<MyPostsContainer> {
  bool selected = true;

  Widget buildGridView() {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemCount: widget.articles.length,
        itemBuilder: (BuildContext context, int index) {
          return ArticleGridView(
            article: widget.articles[index],
            onClick: () {
              Navigator.pushNamed(
                context,
                BlogAppRoutes.ARTICLE_EDIT,
                arguments: widget.articles[index],
              );
            },
            onDelete: () async {
              var ans =
                  await showDeleteDialog(widget.articles[index].title, context);
              if (ans == 'yes') {
                widget.onDelete(widget.articles[index].id);
              }
            },
          );
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
            onDelete: () async {
              var ans = await showDeleteDialog(
                widget.articles[index].title,
                context,
              );
              if (ans == 'yes') {
                widget.onDelete(widget.articles[index].id);
              }
            },
          );
        },
      ),
    );
  }

  showDeleteDialog(String title, context) async {
    return await showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.delete_forever_outlined, color: Colors.redAccent),
              Text('Article Delete'),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("You're deleting article $title"),
                const Text('Are you sure do you want to delete this article?'),
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

  void onSelected(bool value) {
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget myCard = widget.articles.isEmpty
        ? const Column(children: [
            Center(child: Text("You've No Post")),
          ])
        : selected
            ? buildListView()
            : buildGridView();

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 375,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          shadows: const [
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
                    color: Theme.of(context).colorScheme.primary,
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
                  color: !selected
                      ? const Color(0xFF386BED)
                      : Theme.of(context).colorScheme.onBackground,
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
                  color: !selected
                      ? Theme.of(context).colorScheme.onBackground
                      : const Color(0xFF386BED),
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
