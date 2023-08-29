import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/blog_app_routes.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../blocs/article/bloc/article_bloc.dart';
import '../blocs/auth/auth_bloc.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF659AFF),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avator.jpg'),
            ),
            accountName: Text('Ahmed Elsayed'),
            accountEmail: Text('Bazabizi3@gmail.com'),
          ),
          // const DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Color(0xFF659AFF),
          //   ),
          //   child: Text(
          //     'Menu',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 24,
          //     ),
          //   ),
          // ),
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
