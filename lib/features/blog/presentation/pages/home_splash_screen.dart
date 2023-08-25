import 'package:blog_application/core/routes/blog_app_routes.dart';
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
  void initState() {
    super.initState();
//

    Future.delayed(Duration(seconds: 5), () {
      // IsLogedIn ins = sl<IsLogedIn>();
      // bool islogedin = false;
      // String route = islogedin ? BlogAppRoutes.HOME : BlogAppRoutes.ONBOARDING;
      Navigator.popAndPushNamed(context, BlogAppRoutes.ONBOARDING);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 243, 244),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 233,
              height: 94,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://s3-alpha-sig.figma.com/img/5dfb/9301/4f561ba4ead058bb557260f3943c6261?Expires=1693785600&Signature=hOp~3bzooRodDQGA7lkQqjH8OmhlWWF0BZ1f0d-kvn7umVqogihQ3QUowhO0iyVreT8WfcGRk-2nzUauYQGXJRqlqtqN2K1D97i~FoOJu6Km69D383fnE6ICWFTcBK4p8Cd66cqUYsUBleAXVvgxrr-J5j1-biKVDz3XcUR4GZ6X66wWDJmpGe4eGRHSLbXHRq8huT3GLQgDYPsI9WebkFYwh0SjfCpjjkskulJDoeitYrzUqM3t86tJfyUiTv6XT0sKMFnhixZipVTeVo-0vqAu~~5GnGSqEIL1Ms8b371TTWFiKjkm5g6LlgalW-rihGW386q3FKewB2jj8sad9Q__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
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
