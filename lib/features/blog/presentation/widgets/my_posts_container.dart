import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'article_grid_view.dart';
import 'my_post_card.dart';

class MyPostsContainer extends StatelessWidget {
  List<Article> articles;
  
   final void Function(String id) onDelete;
  MyPostsContainer({super.key, required this.articles, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    Widget myPost = Container();
    if(articles.isEmpty){
      myPost = Column(children:[Center(child: Text("You've No Post"),)]);
    } else {
      myPost =Expanded(
              child: 
                GridView(
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    ...articles.map((article) {
                      return ArticleGridView(
                        article : article
                      );
                    }),
                  ],
                ),
              // child: ListView.builder(
              //   itemCount: articles.length,
              //   itemBuilder: (context, index) {
              //     String title = articles[index].title;
              //     if(articles[index].title.length > 50){
              //       title = "${articles[index].title.substring(0,25)}...";
              //     }
              //     String subtitle = articles[index].subTitle;
              //     if(articles[index].subTitle.length > 80){
              //       subtitle = "${articles[index].subTitle.substring(0,80)}...";
              //     }
                  
              //     return MyPostCard(
              //       title: title,
              //       subtitle: subtitle,
              //       date : articles[index].createdAt?? DateTime.now(),
              //       onClick: (){
              //         Navigator.pushNamed(context, BlogAppRoutes.ARTICLE_EDIT,arguments: articles[index]);
              //       },
              //       imageUrl: articles[index].image,
              //       onDelete: (){
              //         onDelete(articles[index].id);
              //       },
              //     );
              //   },
              // ),
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
            const SizedBox(
              height: 20,),
            myPost
          ],
        ),
      ),
    );
  }
}

