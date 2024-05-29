import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scavenger_app/utils/widgets/text_widget.dart';
import 'package:scavenger_app/utils/widgets/wrapp_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ChangeScreen() {
    Future.delayed(
      Duration(seconds: 4),
      () {
        Get.off(WrappWidget());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    ChangeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Objects1.png",
              ),
              SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/images/Objects.png",
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.heading("Attendance",
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontsize: 40,
                      letterSpacing: 1.5,
                      fontFamily: GoogleFonts.dancingScript().fontFamily),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.heading(" Management",
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontsize: 40,
                      letterSpacing: 1.5,
                      fontFamily: GoogleFonts.dancingScript().fontFamily),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.heading(" System",
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontsize: 40,
                      letterSpacing: 1.5,
                      fontFamily: GoogleFonts.dancingScript().fontFamily),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
