import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:flutter/material.dart';

class GridViews extends StatelessWidget {
  final List<Article> articles;
  const GridViews({required this.articles,super.key});


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  String title = articles[index].title;
                  if(articles[index].title.length > 50){
                    title = "${articles[index].title.substring(0,25)}...";
                  }
                  String subtitle = articles[index].subTitle;
                  if(articles[index].subTitle.length > 80){
                    subtitle = "${articles[index].subTitle.substring(0,80)}...";
                  }
                  return null;
                  
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
                },
              ),
            
      
    );
  }
}

