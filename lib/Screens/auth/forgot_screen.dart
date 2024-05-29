
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scavenger_app/utils/custom_color.dart';
import 'package:scavenger_app/utils/widgets/text_widget.dart';

import '../../utils/widgets/TextFormFieldWidget.dart';
import 'package:get/get.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {

  TextEditingController emailController = TextEditingController();

  reset() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
      Get.snackbar("Successfully", "Check your email to reset password",backgroundColor: Colors.green,colorText: Colors.white);
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString(),backgroundColor: Colors.red,colorText: Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
          
                  Image.asset("assets/images/bg1.png",),
                ],),
              Column(
                children: [
                  SizedBox(height: 180),
                  Image.asset("assets/images/Objects.png"),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,),
                child: Column(
                  children: [
                    SizedBox(height: 210),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.heading("Forgot Password",color: Colors.white,fontWeight: FontWeight.w900,fontsize: 32,letterSpacing: 1.0),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.heading("welcome back to scavenger",color:textColor,fontsize: 10,letterSpacing: 1.0),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        AppText.heading("Email",color:textColor,fontsize: 12,letterSpacing: 1.0),
                      ],
                    ),
                    SizedBox(height: 15),
                    TextFormFieldWgt(
                      hintText: "Email",
                      controller: emailController,
                      preicon: Icon(Icons.person_outline_outlined,size: 20,),
                    ),
          
          
          
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: (){
                          reset();
                        },
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [color1, color2], // Add your desired colors here
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.1, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          child: Center(
                            child:    AppText.heading("Send",color:Colors.white,fontsize: 16,letterSpacing: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
          
          
          
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
