import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_application/service_locator.dart'; // Assuming this is where your Blocs are registered.
import 'package:blog_application/features/blog/presentation/blocs/bookmark/bookmark_bloc.dart';
import 'package:blog_application/Route.dart';
import 'package:blog_application/features/blog/presentation/pages/articles_reading_screen.dart';
// Import your BookmarkBloc

// Other imports...

void main() async {
  // Initialize any necessary services or configurations here.
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: BlogAppRoutes.ARTICLE_DETAIL,
      home: // Create an instance of your BookmarkBloc
          ArticleReading(likes: 4), // Replace this with your main screen wid
    );
  }
}
