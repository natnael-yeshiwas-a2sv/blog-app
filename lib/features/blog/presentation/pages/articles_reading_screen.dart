import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/data/models/dto/get_profile_dto.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/domain/entities/user.dart';
import 'package:blog_application/features/blog/presentation/widgets/author_bar.dart';
import 'package:flutter/material.dart';
import 'package:blog_application/features/blog/presentation/widgets/article_reading_title.dart';
import 'package:blog_application/features/blog/presentation/widgets/article_body.dart';

class ArticleReading extends StatefulWidget {
  final int likes;
  final Article article;

  const ArticleReading({
    super.key,
    required this.likes,
    required this.article,
  });

  @override
  _ArticleReadingState createState() => _ArticleReadingState();
}

class _ArticleReadingState extends State<ArticleReading> {
  int _likes = 0;

  @override
  void _increment() {
    setState(() {
      _likes += 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _likes = widget.likes;
  }

  String calculatePostDate(DateTime createdAt) {
    Duration difference = DateTime.now().difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays > 1 ? "days" : "day"} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours > 1 ? "hours" : "hour"} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes > 1 ? "minutes" : "minute"} ago';
    } else {
      return 'Just now';
    }
  }

  bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    String articleText = widget.article.content;
    String articleTitle = widget.article.title;
    String articleImage = widget.article.image;
    String? articleAuthor = widget.article.user?.fullName;
    DateTime? postDate = widget.article.createdAt;
    print(widget.article.createdAt.runtimeType);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.chevron_left,
                color: Theme.of(context).colorScheme.onBackground,
              )),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Icon(
              Icons.more_horiz,
              color: Theme.of(context).colorScheme.onBackground,

            ),
          )
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () => _increment(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.thumb_up_off_alt_outlined),
              Text('$_likes')
            ],
          )),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ArticleReadingTitle(
              title: articleTitle,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, BlogAppRoutes.PROFILE),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: AuthorBar(
                    image: const AssetImage("./assets/images/author_image.png"),
                    name: articleAuthor!,
                    time: calculatePostDate(postDate!),
                    isBookmarked: true),
              ),
            ),
          ]),
        ),
        Expanded(
          child: ArticleBody(article_body: articleText, image: articleImage),
        ),
      ]),
    );
  }
}
