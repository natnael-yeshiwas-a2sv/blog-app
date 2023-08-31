import 'package:blog_application/core/routes/blog_app_routes.dart';
import 'package:blog_application/features/blog/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../widgets/auth_custome_alert.dart";

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool login = true;
  bool hidePassword = true;
  String? confirm, password, username, fullname;
  String? confirmErr = "", passwordErr = "", usernameErr = "", fullnameErr = "";

  bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  void switchAuth() {
    setState(() {
      login = !login;
      confirmErr = passwordErr = usernameErr = fullnameErr = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontNormal = MediaQuery.of(context).size.width * 0.04 + 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 205,
              width: double.infinity,
              child: Image.asset(
                'assets/images/a2sv_blue_2.png',
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 205,
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
                              duration: const Duration(milliseconds: 300),
                              opacity: login ? 1 : .25,
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(
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
                              duration: const Duration(milliseconds: 300),
                              opacity: login ? .25 : 1,
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(
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
                        padding:
                            const EdgeInsets.only(top: 30, left: 50, right: 50),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
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
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: isDarkMode(context)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  login
                                      ? "Sign in with your account"
                                      : "provide credentials to signup",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 45, 67, 121),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: login == false ? 25 : 0),
                                if (!login)
                                  Text(
                                    "Full name",
                                    style: TextStyle(
                                      fontSize: fontNormal,
                                      color: const Color.fromARGB(
                                          255, 45, 67, 121),
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                if (!login)
                                  TextField(
                                    style: TextStyle(fontSize: fontNormal),
                                    onChanged: (String? text) => setState(() {
                                      fullname = text;
                                      fullnameErr = fullname!.isNotEmpty
                                          ? ""
                                          : "invalid full name";
                                    }),
                                    decoration: const InputDecoration(
                                      hintText: "full name",
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 184, 184, 184),
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
                                SizedBox(height: login ? 0 : 2),
                                Text(
                                  fullnameErr ?? "",
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    fontSize: fontNormal,
                                    color:
                                        const Color.fromARGB(255, 45, 67, 121),
                                    fontWeight: FontWeight.w200,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                TextField(
                                  style: TextStyle(fontSize: fontNormal),
                                  onChanged: (String? text) => setState(() {
                                    username = text;
                                    usernameErr = username!.isNotEmpty
                                        ? ""
                                        : "invalid username";
                                  }),
                                  decoration: const InputDecoration(
                                    hintText: "username",
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 184, 184, 184),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 217, 223, 235),
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
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: fontNormal,
                                    color: const Color.fromARGB(255, 45, 67, 121),
                                    fontWeight: FontWeight.w200,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    TextField(
                                      obscureText: hidePassword,
                                      style: TextStyle(fontSize: fontNormal),
                                      onChanged: (String? text) => setState(() {
                                        password = text;
                                        passwordErr = password!.isNotEmpty
                                            ? ""
                                            : "invalid password";
                                      }),
                                      decoration: InputDecoration(
                                        hintText: "password",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontNormal,
                                          color: const Color.fromARGB(
                                              255, 184, 184, 184),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 217, 223, 235),
                                          ),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: GestureDetector(
                                        onLongPress: () {
                                          setState(() {
                                            hidePassword = false;
                                          });
                                        },
                                        onLongPressEnd: (_) {
                                          setState(() {
                                            hidePassword = true;
                                          });
                                        },
                                        child: Text(
                                          hidePassword ? "show" : "hide",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  passwordErr ?? "",
                                  style: const TextStyle(color: Colors.red),
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
                                      color: const Color.fromARGB(255, 55, 106, 237),
                                      padding: const EdgeInsets.all(17),
                                      onPressed: state is AuthLoading
                                          ? null
                                          : () {
                                              if (username != null &&
                                                  username != "" &&
                                                  password != null &&
                                                  password != "") {
                                                if (login == false &&
                                                    (fullname == null ||
                                                        fullname == "")) {
                                                  setState(() {
                                                    fullnameErr =
                                                        "invalid full name";
                                                  });
                                                  return;
                                                }
                                                dynamic sendBloc = login
                                                    ? AuthLogin(username ?? "",
                                                        password ?? "")
                                                    : AuthRegister(
                                                        username ?? "",
                                                        password ?? "",
                                                        fullname ?? "",
                                                      );
                                                context
                                                    .read<AuthBloc>()
                                                    .add(sendBloc);
                                              } else {
                                                setState(() {
                                                  if (username == null ||
                                                      username == "") {
                                                    usernameErr =
                                                        "empty username";
                                                  } else {
                                                    passwordErr =
                                                        "empty password";
                                                  }
                                                });
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                ),
                                const SizedBox(height: 10),
                                BlocListener<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is SignedUp) {
                                      switchAuth();
                                      showAlertDialog(
                                          context,
                                          "You succesfully signed In",
                                          "successfull");
                                    }
                                    if (state is AuthPass) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthRestart());

                                      Navigator.pushNamedAndRemoveUntil(context,
                                          BlogAppRoutes.HOME, (r) => false);
                                    }

                                    if (state is AuthFailed) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(state.error)));
                                    }
                                  },
                                  child: const SizedBox(height: 5,),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Text(
                                  //       login
                                  //           ? "Forget Your Password?"
                                  //           : "Have an account?",
                                  //       style: const TextStyle(
                                  //         fontWeight: FontWeight.w900,
                                  //         color:
                                  //             Color.fromARGB(255, 45, 67, 121),
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 2),
                                  //     TextButton(
                                  //       onPressed: () {
                                  //         if (login == false) {
                                  //           switchAuth();
                                  //         } else {
                                  //           ScaffoldMessenger.of(context)
                                  //               .showSnackBar(const SnackBar(
                                  //                   content: Text(
                                  //                       "sorry,this feature is not available yet!")));
                                  //         }
                                  //       },
                                  //       child: Expanded(
                                  //         child: Text(
                                  //           login ? "reset" : "Login",
                                  //           style: const TextStyle(
                                  //             color: Color.fromARGB(
                                  //                 255, 55, 106, 237),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
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
    );
  }
}
