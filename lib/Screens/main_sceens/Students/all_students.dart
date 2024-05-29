import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scavenger_app/Screens/main_sceens/Students/add_student.dart';
import 'package:scavenger_app/bloc/Student-cubit/students_cubit.dart';
import 'package:scavenger_app/bloc/Student-cubit/students_state.dart';

class AllStudents extends StatefulWidget {
  final String department;
  final String semester;
  final String rollNo;
  final String classesId;
  final String sub;

  const AllStudents(
      {Key? key,
      required this.department,
      required this.semester,
      required this.rollNo,
      required this.classesId,
      required this.sub})
      : super(key: key);

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  @override
  void initState() {
    super.initState();
    getStudents();
  }

  getStudents() async {
    await context.read<StudentsCubit>().getStudentsBySemesterAndDepartment(
        widget.semester, widget.department, widget.sub);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Students',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<StudentsCubit, StudentsState>(
        builder: (context, state) {
          if (state is StudentsLoadedState) {
            state.students.sort((a, b) => a["rollno"].compareTo(b["rollno"]));
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          "Semester",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Department",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                (state is StudentsLoadedState)
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: state.students.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              height: 39.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.students[index]["rollno"]
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.students[index]["name"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.students[index]["semester"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.students[index]["department"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.white.withOpacity(0.4),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(AddingStudentScreen(
            department: widget.department,
            semester: widget.semester,
            classesId: widget.classesId,
            subject: widget.sub,
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
