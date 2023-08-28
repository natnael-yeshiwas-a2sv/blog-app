import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    super.initState();
//

    Future.delayed(const Duration(seconds: 5), () {
      // IsLogedIn ins = sl<IsLogedIn>();
      // bool islogedin = false;
      // String route = islogedin ? BlogAppRoutes.HOME : BlogAppRoutes.ONBOARDING;
      Navigator.popAndPushNamed(context, BlogAppRoutes.ONBOARDING);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 244),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 233,
              height: 94,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/a2sv.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
