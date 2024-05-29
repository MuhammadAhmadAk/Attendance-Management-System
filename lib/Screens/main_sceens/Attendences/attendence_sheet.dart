import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scavenger_app/Screens/home_screen.dart';
import 'package:scavenger_app/bloc/Student-cubit/students_cubit.dart';
import 'package:scavenger_app/bloc/Student-cubit/students_state.dart';
import 'package:scavenger_app/bloc/attendence-cubit/attendence_cubit.dart';
import 'package:scavenger_app/bloc/attendence-cubit/attendence_state.dart';
import 'package:scavenger_app/utils/widgets/custom_buttom.dart';

class AttendenceSheet extends StatefulWidget {
  const AttendenceSheet(
      {Key? key,
      required this.classId,
      required this.department,
      required this.semester,
      required this.subject})
      : super(key: key);
  final String classId;
  final String department;
  final String semester;
  final String subject;

  @override
  State<AttendenceSheet> createState() => _AttendenceSheetState();
}

class _AttendenceSheetState extends State<AttendenceSheet> {
  List<String> presentStudents = [];
  List<String> absentStudents = [];
  List<String> leaveStudents = [];

  @override
  void initState() {
    super.initState();
    getStudent();
  }

  getStudent() async {
    await context.read<StudentsCubit>().getStudentsBySemesterAndDepartment(
        widget.semester, widget.department, widget.subject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Attendance Sheet",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: BlocConsumer<StudentsCubit, StudentsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is StudentsLoadedState) {
            // Sort the students by roll number
            final sortedStudents = state.students
                .map((student) => Map.of(student))
                .toList()
              ..sort((a, b) =>
                  int.parse(a["rollno"]).compareTo(int.parse(b["rollno"])));

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                  height: 39.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "RollNo",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Name",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "P",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "A",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "L",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: sortedStudents.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.white),
                    itemBuilder: (context, index) {
                      final student = sortedStudents[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        height: 39.h,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                student["rollno"],
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                student["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Checkbox(
                                value:
                                    presentStudents.contains(student["rollno"]),
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      presentStudents.add(student["rollno"]);
                                      absentStudents.remove(student["rollno"]);
                                      leaveStudents.remove(student["rollno"]);
                                    } else {
                                      presentStudents.remove(student["rollno"]);
                                    }
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            Expanded(
                              child: Checkbox(
                                value:
                                    absentStudents.contains(student["rollno"]),
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      absentStudents.add(student["rollno"]);
                                      presentStudents.remove(student["rollno"]);
                                      leaveStudents.remove(student["rollno"]);
                                    } else {
                                      absentStudents.remove(student["rollno"]);
                                    }
                                  });
                                },
                                activeColor: Colors.red,
                              ),
                            ),
                            Expanded(
                              child: Checkbox(
                                value:
                                    leaveStudents.contains(student["rollno"]),
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      leaveStudents.add(student["rollno"]);
                                      presentStudents.remove(student["rollno"]);
                                      absentStudents.remove(student["rollno"]);
                                    } else {
                                      leaveStudents.remove(student["rollno"]);
                                    }
                                  });
                                },
                                activeColor: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                BlocConsumer<AttendenceCubit, AttendenceState>(
                  listener: (context, atstate) {
                    if (atstate is AttendenceMarkedState) {
                      Get.off(HomeScreen());
                      Get.snackbar("Attendence", "Attendence Saved",
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1));
                    } else if (atstate is AttendenceErrorState) {
                      Get.snackbar("Error", atstate.error.toString(),
                          backgroundColor: Colors.red);
                    }
                  },
                  builder: (context, atstate) {
                    return (atstate is AttendenceLoadingState)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButtonWidget(
                            text: "Save",
                            onPressed: () {
                              // Implement logic to save attendance data here
                              context.read<AttendenceCubit>().markAttendance(
                                  presentStudents: presentStudents,
                                  absentStudents: absentStudents,
                                  leaveStudents: leaveStudents,
                                  classId: widget.classId,
                                  studentNames: sortedStudents
                                      .map((student) => student["name"])
                                      .toList(),
                                  depName: sortedStudents[0]["department"]
                                      .toString(),
                                  semester: widget.semester,
                                  subject: widget.subject);
                            },
                          );
                  },
                ),
                SizedBox(height: 30.h),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
