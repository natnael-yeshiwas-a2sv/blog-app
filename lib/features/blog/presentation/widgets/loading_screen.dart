import 'package:blog_application/features/blog/presentation/widgets/article_card_skeleton.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16),
          child:ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => const ArticleCardSkelton(),
            separatorBuilder: (context, index) =>
                const SizedBox(height: 16),
                )
      ),
    );
  }
}