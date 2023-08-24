import 'package:blog_application/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:blog_application/features/blog/presentation/pages/articles_reading_screen.dart';
import "./Route.dart" as route;
import "core/routes/blog_app_routes.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3:  true,
    ),
    debugShowCheckedModeBanner: false,
    onGenerateRoute: route.controller,
    initialRoute: BlogAppRoutes.ONBOARDING,
  ));
}
