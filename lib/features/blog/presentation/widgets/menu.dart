import 'package:blog_application/features/blog/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/blog_app_routes.dart';
import '../blocs/auth/auth_bloc.dart';

class Menu extends StatelessWidget {
  final User user;
  const Menu({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var imageUrl = const CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/avator.jpg',
                      ),);
                  if(user.image != null){
                    imageUrl = CircleAvatar(
                      backgroundImage: NetworkImage(user.image!),
                    );
                  
                }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.jpg',
                
                  ),
                fit: BoxFit.cover,
              )
            ),
            currentAccountPicture:imageUrl,
            accountName: Text(user.fullName??'Yidnekachew'),
            accountEmail: Text(user.email ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, BlogAppRoutes.HOME);
            },
          
          ),
          const Divider(
            endIndent: 30,
            indent: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, BlogAppRoutes.PROFILE);
            },
          ),const Divider(
            endIndent: 30,
            indent: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.add,
            ),
            title: const Text('Create Article'),
            onTap: () {
              Navigator.pushNamed(context, BlogAppRoutes.ARTICLE_CREATE);
            },
          ),
          const Divider(
            endIndent: 30,
            indent: 20,
          ),         ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text('Logout'),
            onTap: () => logout(context),
          ),
          const Divider(
            endIndent: 30,
            indent: 20,
          ),
        ],
      ),
    );
  }

  void logout(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogout());
    Navigator.pushNamedAndRemoveUntil(
      context,
      BlogAppRoutes.AUTH,
      (route) => false,
    );
  }
}
