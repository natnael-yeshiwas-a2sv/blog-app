import 'package:blog_application/features/blog/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/blog_app_routes.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../blocs/article/bloc/article_bloc.dart';
import '../blocs/auth/auth_bloc.dart';

class Menu extends StatelessWidget {
  final User user;
  const Menu({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
           UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF659AFF),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avator.jpg'),
            ),
            accountName: Text(user.fullName??'Yidnekachew'),
            accountEmail: Text(user.email ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, BlogAppRoutes.HOME);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, BlogAppRoutes.PROFILE);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () => logout(context),
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
