import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scavenger_app/Screens/main_sceens/Students/add_student.dart';
import 'package:scavenger_app/Screens/main_sceens/adding_new_classes.dart';
import 'package:scavenger_app/utils/widgets/semeter_container.dart';

class ClassSubjectScreen extends StatelessWidget {
  const ClassSubjectScreen(
      {Key? key,
      required this.department,
      required this.semesters,
      required this.subjects,
      required this.dptId})
      : super(key: key);
  final String dptId;
  final String department;
  final String semesters;
  final List<dynamic> subjects;
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Semesters",
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
                    subjects.length, // Replace this with your actual itemCount
                itemBuilder: (context, index) {
                  print(subjects);
                  return GestureDetector(
                    onTap: () {
                      Get.to(AddingStudentScreen(
                        department: department,
                        semester: semesters,
                        classesId: dptId,
                        subject: subjects[index]["subject"],
                      ));
                    },
                    child:
                        SemesterContainer(semester: subjects[index]["subject"]),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(AddingNewClasses());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
//semseter