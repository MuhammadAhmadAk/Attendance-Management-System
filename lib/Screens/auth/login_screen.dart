import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scavenger_app/Screens/auth/forgot_screen.dart';
import 'package:scavenger_app/Screens/auth/register_screen.dart';
import 'package:scavenger_app/Screens/home_screen.dart';
import 'package:scavenger_app/bloc/auth-cubit/auth_cubit.dart';
import 'package:scavenger_app/bloc/auth-cubit/auth_state.dart';
import 'package:scavenger_app/utils/custom_color.dart';
import 'package:scavenger_app/utils/widgets/PwdTextFormFieldWidget.dart';
import 'package:scavenger_app/utils/widgets/TextFormFieldWidget.dart';
import 'package:scavenger_app/utils/widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  login() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(googleAuthCredential);
    Get.offAll(HomeScreen());
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // SignIn() {
  //   FirebaseAuth.instance
  //       .signInWithEmailAndPassword(
  //           email: emailController.text, password: passwordController.text)
  //       .then((value) {
  //     Get.offAll(HomeScreen());
  //   }).onError((error, stackTrace) {
  //     Get.snackbar("Error", "Invalid Email or Password",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedInState) {
            Get.to(HomeScreen());
            Get.snackbar("LoggedIn", "Logged In Successful",
                backgroundColor: Colors.green);
          } else if (state is AuthErrorState) {
            Get.snackbar("Error", state.error.toString(),
                backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/bg1.png",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 180),
                      Image.asset("assets/images/Objects.png"),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 210),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.heading("Welcome Back",
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontsize: 32,
                                letterSpacing: 1.0),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.heading("welcome back to AMS",
                                color: textColor,
                                fontsize: 10,
                                letterSpacing: 1.0),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            AppText.heading("Email",
                                color: textColor,
                                fontsize: 12,
                                letterSpacing: 1.0),
                          ],
                        ),
                        SizedBox(height: 15),
                        TextFormFieldWgt(
                          hintText: "Email",
                          controller: emailController,
                          preicon: Icon(
                            Icons.person_outline_outlined,
                            size: 20,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            AppText.heading("Password",
                                color: textColor,
                                fontsize: 12,
                                letterSpacing: 1.0),
                          ],
                        ),
                        SizedBox(height: 15),
                        PwdTextFormFieldWidget(
                          controller: passwordController,
                          hintText: "Password",
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(ForgotScreen());
                              },
                              child: AppText.heading("Forgot Password ?",
                                  color: textColor,
                                  fontsize: 10,
                                  letterSpacing: 1.0),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: GestureDetector(
                            onTap: () async {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                Get.snackbar(
                                    "Empty Fields", "Please fill the fields ",
                                    backgroundColor: Colors.red);
                              } else {
                                await context.read<AuthCubit>().Login(
                                    emailController.text.trim(),
                                    passwordController.text);
                              }
                            },
                            child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    color1,
                                    color2
                                  ], // Add your desired colors here
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.1, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                              ),
                              child: Center(
                                child: (state is AuthLoadingInState)
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : AppText.heading("Sign In",
                                        color: Colors.white,
                                        fontsize: 16,
                                        letterSpacing: 1.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.heading("Don't have an account ? ",
                                color: textColor,
                                fontsize: 9,
                                letterSpacing: 1.0),
                            GestureDetector(
                              onTap: () {
                                Get.to(RegisterScreen());
                              },
                              child: AppText.heading("Sign Up ",
                                  color: Colors.deepPurple,
                                  fontsize: 10,
                                  letterSpacing: 1.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/l1.png"),
                            SizedBox(
                              width: 10,
                            ),
                            AppText.heading("Or continue with",
                                color: textColor,
                                fontsize: 10,
                                letterSpacing: 1.0),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset("assets/images/l2.png"),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                login();
                              },
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/google.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
