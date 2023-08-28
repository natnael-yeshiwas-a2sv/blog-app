import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  int currentIndex = 0;

  var duration = const Duration(milliseconds: 250);
  var curveEase = Curves.ease;

  neaxtPage() {
    _pageController.nextPage(duration: duration, curve: curveEase);
  }

  previousPage() {
    _pageController.previousPage(duration: duration, curve: curveEase);
  }

  onChangedPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  Widget buildOnboardingBody() {
    return SizedBox(
      // color: Colors.yellow.withOpacity(0.1),
      width: Get.width,
      height: Get.height / 2.8,
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 180,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/sunset.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      offset: const Offset(0, 16), // Offset in the Y direction
                      blurRadius: 16, // Spread of the shadow
                      spreadRadius: 0, // Size of the shadow
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 13,
              ),
              Container(
                width: 200,
                height: 180,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/vr.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      offset: const Offset(0, 16), // Offset in the Y direction
                      blurRadius: 16, // Spread of the shadow
                      spreadRadius: 0, // Size of the shadow
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 180,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/diver.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      offset: const Offset(0, 16), // Offset in the Y direction
                      blurRadius: 16, // Spread of the shadow
                      spreadRadius: 0, // Size of the shadow
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 180,
                // child: Image.asset("assets/images/horizon.png"),

                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/horizon.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      offset: const Offset(0, 16), // Offset in the Y direction
                      blurRadius: 16, // Spread of the shadow
                      spreadRadius: 0, // Size of the shadow
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 48),
            height: Get.height / 1.7,
            child: PageView(
              controller: _pageController,
              onPageChanged: onChangedPage,
              children: [
                buildOnboardingBody(),
                buildOnboardingBody(),
                buildOnboardingBody(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 20, top: 30),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40, top: 40),
                          width: 275,
                          child: const Text(
                            'Read the article you want instantly',
                            style: TextStyle(
                              color: Color(0xFF0D253C),
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w100,
                              height: 1.33,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 40,
                          ),
                          padding: const EdgeInsets.only(left: 7),
                          width: 295,
                          child: const Text(
                            'You can read thousands of articles on Blog Club, save them in the application and share them with your loved ones.',
                            style: TextStyle(
                              color: Color(0xFF2D4379),
                              fontSize: 15,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w900,
                              height: 1.57,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DotIndicator(
                          positionIndex: 0,
                          currentIndex: currentIndex,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        DotIndicator(
                          positionIndex: 1,
                          currentIndex: currentIndex,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        DotIndicator(
                          positionIndex: 2,
                          currentIndex: currentIndex,
                        ),
                        const SizedBox(
                          width: 160,
                        ),
                        Container(
                          // margin: EdgeInsets.only(top: 20, left: 160),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 70,
                          height: 50,
                          child: IconTheme(
                            data: const IconThemeData(
                              color: Colors.white,
                              opacity: 1.0,
                              size: 20,
                            ),
                            child: IconButton(
                              onPressed: () {
                                neaxtPage();
                                if (currentIndex == 2) {
                                  Navigator.pushNamed(
                                      context, BlogAppRoutes.AUTH);
                                }
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // InkWell(onTap: neaxtPage, child: Text("next")),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final int positionIndex;
  final int currentIndex;

  const DotIndicator(
      {super.key, required this.positionIndex, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(left: 5, top: 20),
      height: 10,
      width: positionIndex == currentIndex ? 20 : 10,
      decoration: BoxDecoration(
          color: positionIndex == currentIndex
              ? Colors.blue
              : const Color(0xFFF4F7FF),
          borderRadius: BorderRadius.circular(32)),
      duration: const Duration(milliseconds: 250),
    );
  }
}
