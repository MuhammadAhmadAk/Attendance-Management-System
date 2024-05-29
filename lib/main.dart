import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scavenger_app/Screens/auth/splash_screen.dart';
import 'package:get/get.dart';
import 'package:scavenger_app/bloc/Student-cubit/students_cubit.dart';
import 'package:scavenger_app/bloc/attendence-cubit/attendence_cubit.dart';
import 'package:scavenger_app/bloc/attendent-records/records_cubit.dart';
import 'package:scavenger_app/bloc/auth-cubit/auth_cubit.dart';
import 'package:scavenger_app/bloc/DepartmentId-cubit/department_cubit.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => DepartmentCubit(),
        ),
        BlocProvider(
          create: (context) => StudentsCubit(),
        ),
        BlocProvider(
          create: (context) => AttendenceCubit(),
        ),
        BlocProvider(
          create: (context) => RecordsCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              iconTheme: IconThemeData(
                color: Colors.white, // Set the default icon color to white
              ),
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
