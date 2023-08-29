import 'package:blog_application/features/blog/domain/usecases/get_current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../../core/routes/blog_app_routes.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../blocs/article/bloc/article_bloc.dart';
import '../blocs/auth/auth_bloc.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(AuthUserEvent()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          
          if(state is AuthUser) {
            return Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFF659AFF),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/photocv.jpg'),
                  ),
                  accountName: Text(state.user.fullName?? "Natnael Tafesse"),
                  accountEmail: Text(state.user.email),
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
          else{
            return Drawer(
              child: CircularProgressIndicator(),
            );
          }
        },
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
