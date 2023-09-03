import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/presentation/blocs/article/bloc/article_bloc.dart';
import 'package:blog_application/features/blog/presentation/widgets/connection_lost.dart';
import 'package:blog_application/features/blog/presentation/widgets/custom_input_field.dart';
import 'package:blog_application/features/blog/presentation/widgets/loading_screen.dart';
import 'package:blog_application/features/blog/presentation/widgets/menu.dart';
import 'package:blog_application/features/blog/presentation/widgets/no_article_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  bool networkError = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ArticleBloc>()
        ..add(const LoadArticlesAndTags(searchparams: "", tags: [])),
      child: Scaffold(
        drawer: BlocConsumer<ArticleBloc, ArticleState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ArticlesAndTagLoaded) {
              return Menu(user: state.user);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
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
          centerTitle: true,
          title: const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            BlocConsumer<ArticleBloc, ArticleState>(
              listener: (context, state) {},
              builder: (context, state) {
                var imageUrl = const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    'assets/images/avator.jpg',
                  ),
                );
                if (state is ArticlesAndTagLoaded) {
                  if (state.user.image != null) {
                    imageUrl = CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(state.user.image!),
                    );
                  }
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, BlogAppRoutes.PROFILE),
                    child: imageUrl,
                  ),
                );
              },
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
              networkError = true;
            } else if (state is ArticleAndTagLoading) {
              networkError = false;
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

            var articleCard = SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      String title = articles[index].title;
                      if (title.length > 90) {
                        title = "${title.substring(0, 90)}...";
                      }
                      String date = InputConverter.toDateFormat(
                          articles[index].createdAt);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, BlogAppRoutes.ARTICLE_DETAIL,
                              arguments: articles[index]);
                        },
                        child: Column(
                          children: [
                            ArticleCard(
                              author:
                                  articles[index].user?.fullName ?? 'Joe Doe',
                              date: date,
                              tag: articles[index].tags.isNotEmpty
                                  ? articles[index].tags[0]
                                  : '',
                              title: title,
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
            );

            return Container(
              padding: const EdgeInsets.all(20.0),
              decoration: ShapeDecoration(
                color: isDarkMode(context)
                    ? Theme.of(context).appBarTheme.backgroundColor
                    : const Color(0xFFF8FAFF),
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
                    SizedBox(
                      height: 35,
                      child: ListView.separated(
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.tags.length,
                          itemBuilder: (_, ind) {
                            return FilterTagChip(
                              controller: articleController,
                              name: state.tags[ind],
                              selected:
                                  state.selectedTags.contains(state.tags[ind]),
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
                    const NoArticleFound()
                  else if ((state is ArticlesAndTagLoaded &&
                          state.articles.isNotEmpty) ||
                      (state is ArticlesLoadeds && state.articles.isNotEmpty))
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => dispatchCreate(context),
                        child: articleCard,
                      ),
                    )
                  else if (networkError)
                    ConnectionLost(
                      onRefresh: dispatchRefresh,
                    )
                ],
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

  Future<void> dispatchRefresh(BuildContext context) async {
    BlocProvider.of<ArticleBloc>(context).add(LoadArticlesAndTags(
      searchparams: articleController.text,
      tags: [] ,
    ));
  }
}
