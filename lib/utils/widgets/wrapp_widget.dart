import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scavenger_app/Screens/auth/login_screen.dart';
import 'package:scavenger_app/Screens/home_screen.dart';

class WrappWidget extends StatefulWidget {
  const WrappWidget({super.key});

  @override
  State<WrappWidget> createState() => _WrappWidgetState();
}

class _WrappWidgetState extends State<WrappWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasData) {
                return HomeScreen();
              } else {
                return LoginScreen();
              }
            }));
  }
}
