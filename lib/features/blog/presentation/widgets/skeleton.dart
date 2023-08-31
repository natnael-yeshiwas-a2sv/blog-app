import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Animator(
      tween: Tween<double>(begin: .5, end: 1),
      cycles: 0,
      repeats: 0,
      duration: Duration(milliseconds: 500),
      builder: (BuildContext context, AnimatorState<double> animatorState,
          Widget? child) {
        return Opacity(
          opacity: animatorState.value,
          child: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: isDarkMode(context)
                    ? Colors.black.withBlue(2)
                    : Colors.black.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(16))),
          ),
        );
      },
      // child:
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}
