import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/presentation/pages/onboarding_page.dart';
import 'package:blog_application/features/blog/domain/usecases/isloged_in_usecase.dart';
import 'package:blog_application/service_locator.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Image.asset("assets/images/a2sv.png"),
        nextScreen: Onboarding(),
        splashTransition: SplashTransition.scaleTransition,
        duration: 2000,  // Duration in milliseconds
 
      ),
    );
    
    
    
    
    
  }
}
