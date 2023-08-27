import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/presentation/blocs/article/bloc/article_bloc.dart';
import 'package:blog_application/features/blog/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/presentation/util/input_converter.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/article.dart';
import '../widgets/article_card.dart';
import '../widgets/customized_button.dart';
import '../widgets/filter_tag_chip.dart';

class HomePage extends StatelessWidget {
  final List<Article>? articles;
  final List<String>? tags;
  final articleController = TextEditingController();
  HomePage({super.key, this.articles, this.tags});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ArticleBloc>()
        ..add(const LoadArticlesAndTags(searchparams: "", tags: [])),
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              'assets/icons/Vector.svg',
              width: 20,
              height: 10,
            ),
          ),
          title: const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, BlogAppRoutes.PROFILE),
                child: const CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage(
                    'assets/images/photocv.jpg',
                    
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: CustomizedButton(
          onpressed: () =>
              Navigator.pushNamed(context, BlogAppRoutes.ARTICLE_CREATE),
          icon: const Icon(Icons.add),
        ),
        body: BlocConsumer<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticleAndTagError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is ArticleAndTagLoading) {
              const CircularProgressIndicator();
            }
          },
          builder: (context, state) {
             
            List<Article> articles = [];
            if(state is ArticlesAndTagLoaded){
              articles = state.articles;
            } else if(state is ArticlesLoadeds){
              articles = state.articles;
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFFF8FAFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomInputField(
                      controller: articleController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if ((state is ArticlesAndTagLoaded || state.tags.isNotEmpty))
                      GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          children: [
                            ...state.tags.map((tag) {
                              return FilterTagChip(
                                controller: articleController,
                                name: tag,
                                selected: state.selectedTags.contains(tag),
                              );
                            }),
                          ]),
                       
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is ArticleAndTagLoading) 
               const Center(child:CircularProgressIndicator())
                  else  if ((state is ArticlesAndTagLoaded &&
                            state.articles.isEmpty) ||
                    (state is ArticlesLoadeds && state.articles.isEmpty))
                      Container(
                        child: const Center(
                          child: Text("No Article is found"),
                        ),
                      )
                    else if ((state is ArticlesAndTagLoaded &&
                            state.articles.isNotEmpty) ||
                        (state is ArticlesLoadeds && state.articles.isNotEmpty))
                       
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: articles.length,
                                itemBuilder: (context, index) {
                                  String date = InputConverter.toDateFormat(articles[index].createdAt);
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          BlogAppRoutes.ARTICLE_DETAIL,
                                          arguments: articles[index]
                                          );
                                    },
                                    child: Column(
                                      children: [
                                    

                                        ArticleCard(
                                          
                                          author: articles[index].user
                                                  ?.fullName ??
                                              'Joe Doe',
                                          date: date,
                                          tag: articles[index].tags
                                                  .isNotEmpty
                                              ? articles[index].tags[0]
                                              : '',
                                          title: articles[index].title,
                                          imageUrl: articles[index].image,
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
