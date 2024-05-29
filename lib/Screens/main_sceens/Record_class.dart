import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scavenger_app/Screens/main_sceens/full_record.dart';
import 'package:scavenger_app/utils/widgets/custom_buttom.dart';

import '../../Repositories/attendence_repo.dart';

class RecordClass extends StatefulWidget {
  const RecordClass({Key? key}) : super(key: key);

  @override
  State<RecordClass> createState() => _RecordClassState();
}

class _RecordClassState extends State<RecordClass> {
  final AttendenceRepo _attendenceRepo = AttendenceRepo();

  String? selectedDepartment;
  String? selectedSemester;
  String? selectedSubject;
  String? selectedStatus;
  DateTime? startDate;
  DateTime? endDate;

  List<String> departments = [
    'BSCS',
    'BBA',
    'Math',
    'English',
    'Law',
    'Zoology',
    'Pharmacy',
  ];
  List<String> semesters = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
  ];
  List<String> subjects = [
    'Eng',
    'Math',
    'OOP',
    'PK',
  ];
  final List<String> statuses = ['present', 'absent', 'leave'];

  String formatDate(DateTime? date) {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Record',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    SizedBox(width: 4),
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
                items: departments
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
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
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
                    border: Border.all(color: Colors.white),
                  ),
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
            SizedBox(height: 50.h),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    SizedBox(width: 4),
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
                items: semesters
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
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
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
                    border: Border.all(color: Colors.white),
                  ),
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
            SizedBox(height: 50.h),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Select Subject',
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
                items: subjects
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
                value: selectedSubject,
                onChanged: (String? value) {
                  setState(() {
                    selectedSubject = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  width: 340.w,
                  height: 53.h,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.black,
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
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
                    border: Border.all(color: Colors.white),
                  ),
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
            SizedBox(height: 50.h),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Status',
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
                items: statuses
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
                value: selectedStatus,
                onChanged: (String? value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  width: 340.w,
                  height: 53.h,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.black,
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
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
                    border: Border.all(color: Colors.white),
                  ),
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
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      setState(() {
                        startDate = value;
                      });
                    });
                  },
                  child: Container(
                    height: 40.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        (startDate != null)
                            ? formatDate(startDate)
                            : "Start Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      setState(() {
                        endDate = value;
                      });
                    });
                  },
                  child: Container(
                    height: 40.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        (endDate != null) ? formatDate(endDate) : "End Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomButtonWidget(
              onPressed: () {
                // if (selectedDepartment != null &&
                //     selectedSemester != null &&
                //     selectedSubject != null &&
                //     startDate != null &&
                //     endDate != null &&
                //     selectedStatus != null) {

                Get.to(FullRecord(
                  dapartment: selectedDepartment!,
                  semester: selectedSemester!,
                ));
                // } else {
                //   // Display a message to select all the fields
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text('Please select all fields'),
                //     ),
                //   );
                // }
              },
              text: "Get Record",
            ),
          ],
        ),
      ),
    );
  }
}
