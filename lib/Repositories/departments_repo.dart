import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DepartmentRepo {
  String generateRandom4DigitString() {
    Random random = Random();
    String result = '';
    for (int i = 0; i < 4; i++) {
      result += random.nextInt(10).toString();
    }
    return result;
  }

  Future<void> addDepartment(
    String department,
    String semester,
    String subject,
  ) async {
    try {
      String departmentId = generateRandom4DigitString();
      String uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference departmentsRef =
          FirebaseFirestore.instance.collection("Departments");
      DocumentReference departmentDocRef = departmentsRef.doc(department);

      // Check if the department exists, if not, create it
      if (!(await departmentDocRef.get()).exists) {
        await departmentDocRef.set({
          "departmentId": departmentId,
          "department": department,
          "userId": uid,
        });
      }

      // Generate random IDs for semester and subject
      String subId = generateRandom4DigitString();
      // Add semester under the department
      await departmentDocRef.collection("semesters").doc(semester).set({
        "semester": semester,
      });

      // Add subject under the semester
      await departmentDocRef
          .collection("semesters")
          .doc(semester)
          .collection("subjects")
          .doc("${subject}_${subId}")
          .set({
        "subject": subject,
      });

      print("Department, Semester, and Subject added successfully");
    } catch (e) {
      print("Failed to add data: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getDepartments() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Departments")
          .where('userId', isEqualTo: uid)
          .get();

      List<Map<String, dynamic>> departments = [];
      for (QueryDocumentSnapshot departmentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> departmentData =
            departmentSnapshot.data() as Map<String, dynamic>;
        ;
        departmentData['id'] = departmentSnapshot.id;

        QuerySnapshot semestersSnapshot =
            await departmentSnapshot.reference.collection('semesters').get();

        List<Map<String, dynamic>> semesters = [];
        for (QueryDocumentSnapshot semesterSnapshot in semestersSnapshot.docs) {
          Map<String, dynamic> semesterData =
              semesterSnapshot.data() as Map<String, dynamic>;
          semesterData['id'] = semesterSnapshot.id;

          QuerySnapshot subjectsSnapshot =
              await semesterSnapshot.reference.collection('subjects').get();

          List<Map<String, dynamic>> subjects = subjectsSnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          semesterData['subjects'] = subjects;
          semesters.add(semesterData);
        }

        departmentData['semesters'] = semesters;
        departments.add(departmentData);
      }

      return departments;
    } catch (e) {
      print("Failed to get departments: $e");
      rethrow;
    }
  }
}
