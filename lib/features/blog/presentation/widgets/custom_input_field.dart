import 'package:blog_application/features/blog/presentation/blocs/article/bloc/article_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'customized_button.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  const CustomInputField({super.key, required this.controller});

  bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 396,
      height: 50.43,
      decoration: ShapeDecoration(
        color: isDarkMode(context)
            ? const Color.fromARGB(255, 29, 26, 34)
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: isDarkMode(context)
                ? const Color.fromARGB(255, 61, 51, 77)
                : const Color(0x3FB1B1B1),
            blurRadius: isDarkMode(context) ? 2 : 6,
            offset: isDarkMode(context) ? const Offset(0, 0) : const Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'search and article...',
          hintStyle: const TextStyle(
            color: Color(0xFF9A9494),
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
          suffixIcon: CustomizedButton(
            icon: const Icon(Icons.search),
            onpressed: () => dispatchCreate(context),
          ),
        ),
      ),
    );
  }

  void dispatchCreate(BuildContext context) {
    BlocProvider.of<ArticleBloc>(context).add(LoadAllArticles(
      searchparams: controller.text,
      selectedTag: "",
    ));
  }
}
