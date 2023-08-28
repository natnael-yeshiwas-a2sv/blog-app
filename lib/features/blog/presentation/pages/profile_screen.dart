import 'package:blog_application/features/blog/domain/entities/article.dart';
import 'package:blog_application/features/blog/presentation/blocs/profile/profile_bloc.dart';
import 'package:blog_application/features/blog/presentation/widgets/my_posts_container.dart';
import 'package:blog_application/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/profile_card.dart';
import '../widgets/profile_tab.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> sl<ProfileBloc>()..add(GetProfileEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Profile'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
        body:
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context,state) {
                if(state is ProfileLoading){
                    return Center(child: CircularProgressIndicator()); 
                } else if(state is ProfileFailed){
                  return Center(child: Text("Failed to load profile"));
                } else if(state is ProfileLoaded){
                  return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 370,
                        child: Stack(
                           alignment: Alignment.topCenter,
                          children: [
                           ProfileCard(user: state.user),
                            Positioned(
                                bottom: 40,
                                child: ProfileTab()),
                          ],
                        ),
                    ),
                    ),
                    MyPostsContainer(articles: state.articles),
                  ],
                );
                }
                return Container();
              }
            ),
      ),
    );
  }
}