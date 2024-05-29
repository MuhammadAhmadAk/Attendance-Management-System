import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemesterContainer extends StatelessWidget {
  final String semester;
  const SemesterContainer({
    Key? key,
    required this.semester,
  }) : super(key: key);

  Color _generateColor(String departmentName) {
    // Generate a color based on the department name
    // You can use any logic to generate the color
    // Here, I'm using a simple hash function to generate a color
    int hash = departmentName.hashCode;
    return Color(hash).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    Color avatarColor = _generateColor(semester);

    return Container(
      height: 100.h,
      width: 330.w,
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          leading: CircleAvatar(
            radius: 30.r,
            backgroundColor: avatarColor, // Use generated color
            child: Text(
              semester[0],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            semester,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
