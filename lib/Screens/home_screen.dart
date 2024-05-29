import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scavenger_app/Screens/main_sceens/Record_class.dart';
import 'package:scavenger_app/Screens/main_sceens/Attendences/attendance_class.dart';
import 'package:scavenger_app/Screens/main_sceens/classes.dart';
import 'package:scavenger_app/utils/custom_color.dart';
import 'package:scavenger_app/utils/widgets/custom_buttom.dart';
import 'package:scavenger_app/utils/widgets/text_widget.dart';

import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      drawer: Drawer(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 1),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 28.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        scafoldKey.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  Text(
                    "Home",
                    style: TextStyle(fontSize: 30.sp, color: Colors.white),
                  ),
                  Container()
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GestureDetector(
                onTap: () {
                  Get.to(ClassesScreen());
                },
                child: Container(
                  height: 165.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    gradient: LinearGradient(
                      colors: [color1, color2], // Add your desired colors here
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.1, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Row(children: [
                    Image.asset("assets/images/classes.png"),
                    SizedBox(
                      width: 20,
                    ),
                    AppText.heading("Classes",
                        color: Colors.white,
                        fontsize: 16.sp,
                        letterSpacing: 1.0),
                  ]),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GestureDetector(
                onTap: () {
                  Get.to(AttendanceClass());
                },
                child: Container(
                  height: 165.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    gradient: LinearGradient(
                      colors: [color1, color2], // Add your desired colors here
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.1, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Row(children: [
                    Image.asset("assets/images/attendance1.png"),
                    SizedBox(
                      width: 10,
                    ),
                    AppText.heading("Attendance",
                        color: Colors.white,
                        fontsize: 16.sp,
                        letterSpacing: 1.0),
                  ]),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GestureDetector(
                onTap: () {
                  Get.to(RecordClass());
                },
                child: Container(
                  height: 165.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    gradient: LinearGradient(
                      colors: [color1, color2], // Add your desired colors here
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.1, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/images/Teach_Attendance.png"),
                      SizedBox(
                        width: 20,
                      ),
                      AppText.heading("Record",
                          color: Colors.white,
                          fontsize: 16.sp,
                          letterSpacing: 1.0),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButtonWidget(
                buttonWidth: 200.w,
                text: "Logout",
                onPressed: () {
                  signOut();
                  Get.offAll(LoginScreen());
                })
          ],
        ),
      ),
    );
  }
}
