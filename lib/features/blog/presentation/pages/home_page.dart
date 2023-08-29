import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/presentation/blocs/article/bloc/article_bloc.dart';
import 'package:blog_application/features/blog/presentation/widgets/custom_input_field.dart';
import 'package:blog_application/features/blog/presentation/widgets/loading_screen.dart';
import 'package:blog_application/features/blog/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/presentation/util/input_converter.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/article.dart';
import '../blocs/auth/auth_bloc.dart';
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
        drawer: const Menu(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.sort,
                size: 35,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
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
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, BlogAppRoutes.PROFILE),
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
              const LoadingScreen();
            }
          },
          builder: (context, state) {
            List<Article> articles = [];
            if (state is ArticlesAndTagLoaded) {
              articles = state.articles;
            } else if (state is ArticlesLoadeds) {
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
                    if ((state is ArticlesAndTagLoaded ||
                        state.tags.isNotEmpty))
                      SizedBox(
                        height: 50,
                        child: ListView.separated(
                          separatorBuilder: (_,__) => SizedBox(width: 10),
                           scrollDirection: Axis.horizontal,
                           itemCount: state.tags.length, 
                           itemBuilder: (_, ind) {
                          return FilterTagChip(
                            controller: articleController,
                            name: state.tags[ind],
                            selected: state.selectedTags.contains(state.tags[ind]),
                          );
                        }),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is ArticleAndTagLoading)
                      const LoadingScreen()
                    else if ((state is ArticlesAndTagLoaded &&
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
                        child: RefreshIndicator(
                          onRefresh: () => dispatchCreate(context),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: articles.length,
                                  itemBuilder: (context, index) {
                                    String date = InputConverter.toDateFormat(
                                        articles[index].createdAt);
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            BlogAppRoutes.ARTICLE_DETAIL,
                                            arguments: articles[index]);
                                      },
                                      child: Column(
                                        children: [
                                          ArticleCard(
                                            author: articles[index]
                                                    .user
                                                    ?.fullName ??
                                                'Joe Doe',
                                            date: date,
                                            tag: articles[index].tags.isNotEmpty
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

  Future<void> dispatchCreate(BuildContext context) async {
    BlocProvider.of<ArticleBloc>(context).add(LoadAllArticles(
      searchparams: articleController.text,
      selectedTag: "",
    ));
  }
}
