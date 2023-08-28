import "package:blog_application/features/blog/data/models/dto/article_model.dart";
import "package:blog_application/features/blog/data/models/dto/get_profile_dto.dart";
import "package:blog_application/features/blog/domain/entities/article.dart";
import "package:blog_application/features/blog/presentation/pages/create_article_screans.dart";
import "package:blog_application/features/blog/presentation/pages/home_page.dart";
import "package:blog_application/features/blog/presentation/pages/onboarding_page.dart";
import "package:blog_application/features/blog/presentation/pages/profile_screen.dart";
import 'package:flutter/material.dart';
import "./core/routes/blog_app_routes.dart";
import "./features/blog/presentation/pages/home_splash_screen.dart";
import "./features/blog/presentation/pages/auth.dart";
import "./features/blog/presentation/pages/articles_reading_screen.dart";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case BlogAppRoutes.SPLASH:
      return MaterialPageRoute(builder: (context) => const home());
    case BlogAppRoutes.AUTH:
      return MaterialPageRoute(builder: (context) => const Auth());
    case BlogAppRoutes.ARTICLE_DETAIL:
      final Article article = settings.arguments as Article;
      return MaterialPageRoute(
        builder: (context) => ArticleReading(likes: 4, article: article),
      );
    case BlogAppRoutes.HOME:
      return MaterialPageRoute(builder: (context) => HomePage());
    case BlogAppRoutes.ARTICLE_CREATE:
      return MaterialPageRoute(builder: (context) => CreateTaskScreen());
    case BlogAppRoutes.PROFILE:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());
    case BlogAppRoutes.ONBOARDING:
      return MaterialPageRoute(builder: (context) => const Onboarding());
    default:
      return throw ("invalid navigation");
  }
}
