import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/presentation/blocs/auth/auth_bloc.dart';
import 'package:blog_application/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool login = true;
  bool hidePassword = true;
  String? confirm, password, username;
  String? confirmErr = "", passwordErr = "", usernameErr = "";

  void switchAuth() {
    setState(() {
      login = !login;
      confirmErr = passwordErr = usernameErr = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 235,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/a2sv_blue_2.png',
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 235,
                    child: Stack(
                      children: [
                        Container(
                          height: 96,
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 16),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 55, 106, 237),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (login == false) switchAuth();
                                },
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 300),
                                  opacity: login ? 1 : .25,
                                  child: const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (login == true) switchAuth();
                                },
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 300),
                                  opacity: login ? .25 : 1,
                                  child: const Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 73,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 30, left: 50, right: 50),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28),
                                topRight: Radius.circular(28),
                              ),
                            ),
                            // main components
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      login ? "Welcome back" : "Welcome",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 13, 37, 60),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      login
                                          ? "Sign in with your account"
                                          : "provide credentials to signup",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 45, 67, 121),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    const Text(
                                      "Username",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 45, 67, 121),
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    TextField(
                                      style: const TextStyle(fontSize: 17),
                                      onChanged: (String? text) => setState(() {
                                        username = text;
                                        usernameErr = username!.isNotEmpty
                                            ? ""
                                            : "invalid username";
                                      }),
                                      decoration: const InputDecoration(
                                        hintText: "username",
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 184, 184, 184),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 217, 223, 235),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      usernameErr ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    const SizedBox(height: 7),
                                    const Text(
                                      "Password",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 45, 67, 121),
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        TextField(
                                          obscureText: hidePassword,
                                          onChanged: (String? text) =>
                                              setState(() {
                                            password = text;
                                            passwordErr = password!.isNotEmpty
                                                ? ""
                                                : "invalid password";
                                          }),
                                          style: const TextStyle(fontSize: 22),
                                          decoration: const InputDecoration(
                                            hintText: "password",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  255, 184, 184, 184),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 217, 223, 235),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  hidePassword = !hidePassword;
                                                });
                                              },
                                              child: Text(
                                                hidePassword ? "show" : "hide",
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      passwordErr ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: MaterialButton(
                                          minWidth: double.infinity,
                                          disabledColor: const Color.fromARGB(
                                              255, 230, 230, 230),
                                          color:
                                              Color.fromARGB(255, 55, 106, 237),
                                          padding: EdgeInsets.all(17),
                                          onPressed: state is AuthLoading
                                              ? null
                                              : () {
                                                  if (username!.isEmpty ==
                                                          false &&
                                                      password!.isEmpty ==
                                                          false) {
                                                    dynamic sendBloc = login
                                                        ? AuthLogin(
                                                            username ?? "",
                                                            password ?? "")
                                                        : AuthRegister(
                                                            username ?? "",
                                                            password ?? "");
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(sendBloc);
                                                  }

                                                  if (state is AuthFailed) {
                                                    print("----");
                                                    print(state.error);
                                                    print("----");
                                                  }
                                                },
                                          child: state is AuthLoading
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  login ? "LOGIN" : "SIGN UP",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                    ),
                                    const SizedBox(height: 10),
                                    BlocListener<AuthBloc, AuthState>(
                                      listener: (context, state) {
                                        if (state is AuthPass) {
                                          Navigator.popAndPushNamed(
                                              context, BlogAppRoutes.HOME);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            login
                                                ? "Forget Your Password?"
                                                : "Have an account?",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 45, 67, 121),
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          TextButton(
                                            onPressed: () {
                                              if (login == false) {
                                                switchAuth();
                                              }
                                            },
                                            child: Text(
                                              login ? "Reset here" : "Login",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 55, 106, 237),
                                                fontSize: 14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ));
  }
}
