import 'package:flutter/material.dart';

class NoArticleFound extends StatelessWidget {
  const NoArticleFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/no_result2.png'),
            height: 200,
            width: 500,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "We couldn't find what you are searching for.\n Please try again with different tags",
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
