import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendenceRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  Future<void> markAttendance({
    required String userId,
    required String classId,
    required String studentRollNo,
    required String studentName,
    required String depName,
    required String semester,
    required String subject,
    required bool present,
    required bool absent,
    required bool onLeave,
  }) async {
    try {
      // Get the current date as a string
      String currentDate = DateTime.now().toIso8601String().split('T').first;

      // Reference to the specific class document
      DocumentReference classDocRef =
          _firestore.collection("Attendances").doc(depName);
      DocumentReference semsDoc =
          classDocRef.collection("semester").doc(semester);
      DocumentReference subjects = semsDoc.collection("subjects").doc(subject);
      DocumentReference dateDocRef =
          subjects.collection('dates').doc(currentDate);
      // Prepare attendance data
      Map<String, dynamic> attendanceData = {
        'userId': userId,
        'classId': classId,
        'className': depName,
        'studentRollNo': studentRollNo,
        'studentName': studentName,
        "semester": semester,
        "subject": subject,
        'present': present,
        'absent': absent,
        'onLeave': onLeave,
      };

      // Add or update the attendance data for the student on the specific date
      await dateDocRef
          .collection('students')
          .doc(studentRollNo)
          .set(attendanceData, SetOptions(merge: true));
    } catch (e) {
      print('Error marking attendance: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAttendanceRecordsWithinDateRange({
    required String depName,
    required String semester,
    required String subject,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
  }) async {
    try {
      String startDate1 = startDate.toIso8601String().split('T').first;
      String endDate1 = endDate.toIso8601String().split('T').first;
      print("$startDate1: $endDate1");
      // Reference to the specific attendance document
      CollectionReference attendanceCollectionRef = FirebaseFirestore.instance
          .collection("Attendances")
          .doc(depName)
          .collection("semester")
          .doc(semester)
          .collection("subjects")
          .doc(subject)
          .collection('dates');

      // Query for attendance records within the specified date range and status
      QuerySnapshot snapshot = await attendanceCollectionRef
          .where(FieldPath.documentId,
              isGreaterThanOrEqualTo: startDate1, isLessThanOrEqualTo: endDate1)
          .get();

      // Extract attendance data from snapshot
      List<Map<String, dynamic>> attendanceRecords = [];

      snapshot.docs.forEach((dateDoc) {
        dateDoc.reference
            .collection('students')
            .where(status, isEqualTo: true)
            .get()
            .then((QuerySnapshot studentSnapshot) {
          studentSnapshot.docs.forEach((studentDoc) {
            attendanceRecords.add(studentDoc.data() as Map<String, dynamic>);
          });
        });
      });

      return attendanceRecords;
    } catch (e) {
      print('Error getting attendance records within date range: $e');
      rethrow;
    }
  }

  Future<List<String>> getDepartments() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection("Attendances").get();
      List<String> departments = snapshot.docs.map((doc) => doc.id).toList();
      print('Fetched departments: $departments \n snapshot : ${snapshot.docs}');
      return departments;
    } catch (e) {
      print('Error fetching departments: $e');
      throw Exception("Error fetching departments: $e");
    }
  }

  Future<List<String>> getSemesters(String depName) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("Attendances")
          .doc(depName)
          .collection("semesters")
          .get();
      List<String> semesters = snapshot.docs.map((doc) => doc.id).toList();
      print('Fetched semesters for $depName: $semesters');
      return semesters;
    } catch (e) {
      print('Error fetching semesters: $e');
      throw Exception("Error fetching departments: $e");
    }
  }

  Future<List<String>> getSubjects(String department, String semester) async {
    print(department);
    print(semester);
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("Attendances")
          .doc(department)
          .collection("semesters")
          .doc(semester)
          .collection('subjects')
          .get();
      List<String> subjects = snapshot.docs.map((doc) => doc.id).toList();
      print('Fetched subjects for $department -> $semester: $subjects');
      return subjects;
    } catch (e) {
      print('Error fetching subjects: $e');
      throw Exception("Error fetching departments: $e");
    }
  }

  // Function to check if two dates are the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
