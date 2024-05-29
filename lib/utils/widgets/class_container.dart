import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassContainer extends StatelessWidget {
  final String departmentName;

  const ClassContainer({
    Key? key,
    required this.departmentName,
  }) : super(key: key);

  Color _generateColor(String departmentName) {
    int hash = departmentName.hashCode;
    return Color(hash).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    Color avatarColor = _generateColor(departmentName);

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
              departmentName[0],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            departmentName,
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
