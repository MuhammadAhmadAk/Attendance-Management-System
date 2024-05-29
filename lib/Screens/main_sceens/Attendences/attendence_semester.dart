import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scavenger_app/Screens/main_sceens/Attendences/attendence_subject.dart';

import '../../../utils/widgets/semeter_container.dart';

class AttendenceSemester extends StatelessWidget {
  const AttendenceSemester(
      {super.key,
      required this.deptId,
      required this.department,
      required this.semesters});

  final String deptId;
  final String department;
  final List<dynamic> semesters;
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          department,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 0.8),
                  ),
                  hintText: 'Search Classes',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount:
                    semesters.length, // Replace this with your actual itemCount
                itemBuilder: (context, index) {
                  List<dynamic> subj = semesters[index]["subjects"];

                  return GestureDetector(
                    onTap: () {
                      Get.to(AttendenceSubject(
                        department: department,
                        semesters: semesters[index]["semester"].toString(),
                        subjects: subj,
                        dptId: deptId,
                      ));
                    },
                    child: SemesterContainer(
                        semester: semesters[index]["semester"]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
