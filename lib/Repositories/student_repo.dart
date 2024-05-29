import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRepo {
  String generateRandom4DigitString() {
    Random random = Random();
    String result = '';
    for (int i = 0; i < 4; i++) {
      result += random.nextInt(10).toString();
    }
    return result;
  }

  Future<void> addStudent(String userId, String classId, String rollno,
      String name, String department, String semester, String subject) async {
    String studId = generateRandom4DigitString();
    try {
      final CollectionReference studentsCollection = FirebaseFirestore.instance
          .collection('students'); // Change collection reference to 'students'
      var stdDoc = studentsCollection
          .doc(studId); // Let Firestore generate unique document ID
      await stdDoc.set({
        'userId': userId,
        'classId':
            classId, // Store class ID to associate the student with the class
        'rollno': rollno,
        'name': name,
        'department': department,
        'semester': semester,
        "subject": subject,
        "timeStamp": DateTime.timestamp().toIso8601String()
      });
      print('Student added successfully');
    } catch (e) {
      print('Failed to add student: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getStudentsByClass(String classId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('students')
              .where('classId', isEqualTo: classId)
              .get();

      List<Map<String, dynamic>> students = [];
      querySnapshot.docs.forEach((doc) {
        students.add(doc.data());
      });

      return students;
    } catch (e) {
      print('Failed to get students: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getStudentsBySemesterAndDepartment(
      String semester, String department, String subject) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('students')
              .where('semester', isEqualTo: semester)
              .where('department', isEqualTo: department)
              .where('subject', isEqualTo: subject)
              .get();

      List<Map<String, dynamic>> students = [];
      querySnapshot.docs.forEach((doc) {
        students.add(doc.data());
      });

      return students;
    } catch (e) {
      print('Failed to get students: $e');
      rethrow;
    }
  }
}
