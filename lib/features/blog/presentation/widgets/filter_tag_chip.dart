import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/bloc/article_bloc.dart';

class FilterTagChip extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final bool selected;
  FilterTagChip({
    Key? key,
    required this.controller,
    required this.name,
    required this.selected,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      
      selected: selected,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      showCheckmark: false,
      selectedColor: Theme.of(context).colorScheme.primary,
      onSelected: (bool value) {
        dispatchSearch(context);
      },
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      side: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Center(
        child: Text(
          name,
          style: TextStyle(
            color: selected
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(75),
      ),
    );
  }

  void dispatchSearch(BuildContext context) {
      BlocProvider.of<ArticleBloc>(context).add(LoadAllArticles(
        searchparams: controller.text,
        selectedTag: name,
        
      ));
    
  }
}
