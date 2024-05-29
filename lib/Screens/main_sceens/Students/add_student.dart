import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scavenger_app/Screens/main_sceens/Students/all_students.dart';
import 'package:scavenger_app/bloc/Student-cubit/students_cubit.dart';
import 'package:scavenger_app/bloc/Student-cubit/students_state.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/widgets/TextFormFieldWidget.dart';
import '../../../utils/widgets/custom_buttom.dart';

class AddingStudentScreen extends StatefulWidget {
  final String department;
  final String semester;
  final String classesId;
  final String subject;
  const AddingStudentScreen({
    Key? key,
    required this.department,
    required this.semester,
    required this.classesId,
    required this.subject,
  }) : super(key: key);

  @override
  _AddingStudentScreenState createState() => _AddingStudentScreenState();
}

class _AddingStudentScreenState extends State<AddingStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController IdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  int currentNumber = 2000;

  @override
  void initState() {
    super.initState();

    departmentController.text = widget.department;
    semesterController.text = widget.semester;
    classNameController.text = widget.subject;
  }

  void clearController() {
    nameController.clear();
    IdController.clear();
  }

  List<String> subject = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Student",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<StudentsCubit, StudentsState>(
        listener: (context, state) {
          if (state is StudentsAddedState) {
            Get.snackbar("Student", "Student Added",
                backgroundColor: Colors.green, duration: Duration(seconds: 1));
            clearController();
          } else if (state is StudentsErrorState) {
            Get.snackbar("Error", state.error.toString(),
                backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 20.h),
                      TextFormFieldWgt(
                        labelText: "Roll No",
                        controller: IdController,
                        hintText: 'Roll No',
                        readOnly: false,
                      ),
                      SizedBox(height: 25.h),
                      TextFormFieldWgt(
                        labelText: "Name",
                        controller: nameController,
                        hintText: 'Name',
                      ),
                      SizedBox(height: 25.h),
                      TextFormFieldWgt(
                        labelText: "Department",
                        controller: departmentController,
                        hintText: 'Department',
                        readOnly: true,
                      ),
                      SizedBox(height: 25.h),
                      TextFormFieldWgt(
                        labelText: "Subject",
                        controller: classNameController,
                        hintText: 'Subject',
                        readOnly: true,
                      ),
                      SizedBox(height: 25.h),
                      TextFormFieldWgt(
                        labelText: "Semester",
                        controller: semesterController,
                        hintText: 'Semester',
                        readOnly: true,
                      ),
                      SizedBox(height: 25.h),
                      (state is StudentsLoadingState)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButtonWidget(
                              text: "Add",
                              buttonHeight: 50.h,
                              buttonWidth: 300.w,
                              gradient:
                                  LinearGradient(colors: [color2, color1]),
                              onPressed: () async {
                                await context.read<StudentsCubit>().addStudent(
                                    widget.classesId,
                                    IdController.text,
                                    nameController.text,
                                    departmentController.text,
                                    semesterController.text,
                                    classNameController.text);
                              },
                            ),
                      SizedBox(height: 20.h),
                      CustomButtonWidget(
                        text: "View Student",
                        buttonHeight: 50.h,
                        buttonWidth: 300.w,
                        gradient: LinearGradient(colors: [color2, color1]),
                        onPressed: () async {
                          Get.off(AllStudents(
                            department: widget.department,
                            semester: widget.semester,
                            rollNo: IdController.text,
                            classesId: widget.classesId,
                            sub: widget.subject,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
