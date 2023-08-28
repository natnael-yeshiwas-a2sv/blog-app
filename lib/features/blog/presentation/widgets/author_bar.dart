import 'dart:ffi';

import 'package:blog_application/features/blog/presentation/blocs/article/bloc/article_bloc.dart';
import 'package:blog_application/features/blog/presentation/blocs/bookmark/bookmark_bloc.dart';

import 'package:blog_application/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorBar extends StatefulWidget {
  final ImageProvider<Object> image;
  final String name;
  final String time;
  final bool isBookmarked;

  const AuthorBar(
      {super.key,
      required this.image,
      required this.name,
      required this.time,
      required this.isBookmarked});

  _AuthorBarState createState() => _AuthorBarState();
}

class _AuthorBarState extends State<AuthorBar> {
  late BookmarkBloc _bookmarkBloc;

  @override
  void initState() {
    super.initState();
    _bookmarkBloc = sl<BookmarkBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bookmarkBloc,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            SizedBox(
              width: 38,
              height: 38,
              child: Container(
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: widget.image,
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Color(0xFF2D4379),
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4, // Add some space between the name and time
                  ),
                  Text(
                    widget.time,
                    style: const TextStyle(
                      color: Color(0xFF7B8BB2),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ]),
          BlocBuilder<BookmarkBloc, BookmarkState>(
            bloc: _bookmarkBloc,
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  _bookmarkBloc.add(ToggleBookmarkEvent(
                      id: "1")); // Dispatch ToggleBookmarkEvent
                },
                icon: Icon(
                  state.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: Color(0xFF2D4379),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
