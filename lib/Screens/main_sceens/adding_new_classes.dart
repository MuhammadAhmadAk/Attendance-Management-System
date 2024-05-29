import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scavenger_app/Screens/main_sceens/classes.dart';
import 'package:scavenger_app/bloc/DepartmentId-cubit/department_cubit.dart';
import 'package:scavenger_app/bloc/DepartmentId-cubit/department_state.dart';
import 'package:scavenger_app/utils/custom_color.dart';
import 'package:scavenger_app/utils/widgets/TextFormFieldWidget.dart';
import '../../utils/widgets/custom_buttom.dart';

class AddingNewClasses extends StatefulWidget {
  const AddingNewClasses({super.key});

  @override
  State<AddingNewClasses> createState() => _AddingNewClassesState();
}

class _AddingNewClassesState extends State<AddingNewClasses> {
  TextEditingController classController = TextEditingController();

  final List<String> depList = [
    'BSCS',
    'BBA',
    'Math',
    'English',
    'Law',
    'Zoology',
    'Pharmacy',
  ];
  final List<String> semList = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
  ];
  final List<String> sub = [
    'Eng',
    'math',
    'OOP',
    'PK',
  ];
  String? selectedDepartment;
  String? selectedSemester;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Class",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<DepartmentCubit, DepartmentState>(
        listener: (context, state) {
          if (state is DepartmentAddedState) {
            Get.off(ClassesScreen());
            Get.snackbar("Department", "Department Added",
                backgroundColor: Colors.green);
          } else if (state is DepartmentErrorState) {
            Get.snackbar("Error", state.error.toString(),
                backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black
                ], // Replace with your desired colors
                begin:
                    Alignment.topLeft, // Customize the gradient's start point
                end:
                    Alignment.bottomRight, // Customize the gradient's end point
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormFieldWgt(
                  controller: classController,
                  hintText: 'Class',
                ),
                SizedBox(
                  height: 50.h,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Department',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: depList
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedDepartment,
                    onChanged: (String? value) {
                      setState(() {
                        selectedDepartment = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      width: 340.w,
                      height: 53.h,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.black,
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3))),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        LineIcons.arrowCircleDown,
                        color: Colors.white,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.black,
                          border: Border.all(color: Colors.white)),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStatePropertyAll(2),
                        thumbVisibility: WidgetStatePropertyAll(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Semester',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: semList
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedSemester,
                    onChanged: (String? value) {
                      setState(() {
                        selectedSemester = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      width: 340.w,
                      height: 53.h,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.black,
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3))),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        LineIcons.arrowCircleDown,
                        color: Colors.white,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.black,
                          border: Border.all(color: Colors.white)),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStatePropertyAll(2),
                        thumbVisibility: WidgetStatePropertyAll(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                (state is DepartmentLoadingState)
                    ? Center(child: CircularProgressIndicator())
                    : CustomButtonWidget(
                        text: "Add",
                        buttonHeight: 50.h,
                        gradient: LinearGradient(colors: [color2, color1]),
                        onPressed: () async {
                          await context.read<DepartmentCubit>().addDepartment(
                                classController.text,
                                selectedDepartment!,
                                selectedSemester!,
                              );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
