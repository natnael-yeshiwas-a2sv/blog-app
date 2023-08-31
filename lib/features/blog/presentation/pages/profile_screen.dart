import 'dart:io';

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
    showMyDialog(File file) async {
      return await showDialog<String>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Profile Image Change'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.file(file, scale: 0.4,fit: BoxFit.contain),
                  const Text('Are you sure do you want to change your profile?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context, 'no');
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, 'yes');
                },
              ),
            ],
          );
        },
      );
    }

    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfileEvent()),
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
            BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          if (state is ProfileUploaded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Profile Picture Uploaded SuccessFully')));
          } else if (state is ProfileUploadFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile Picture Uploaded Failed')));
          } else if (state is ArticleDeleted){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Article Successfully Deleted')));
          }
        }, builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileFailed) {
            return const Center(child: Text("Failed to load profile"));
          } else if (state is ProfileLoaded ||
              state is ProfileUploading ||
              state is ProfileUploaded || state is ArticleDeleted) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 370,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ProfileCard(
                          user: state.user,
                          onSelected: (file) async {
                            if (file != null) {
                              var ans = await showMyDialog(file);
                              print(ans);
                              if (ans == 'yes') {
                                context
                                    .read<ProfileBloc>()
                                    .add(UploadProfilePic(image: file));
                              }
                            }
                          },
                          file: state.file,
                          uploading: state is ProfileUploading,
                        ),
                        const Positioned(bottom: 40, child: ProfileTab()),
                      ],
                    ),
                  ),
                ),
                MyPostsContainer(
                  articles: state.articles,
                  onDelete: (id) => context
                      .read<ProfileBloc>()
                      .add(DeleteArticleEvent(id: id)),
                ),
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
