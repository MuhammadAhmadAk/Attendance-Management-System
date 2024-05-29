import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_app/Repositories/attendence_repo.dart';
import 'package:scavenger_app/bloc/attendence-cubit/attendence_state.dart';

class AttendenceCubit extends Cubit<AttendenceState> {
  AttendenceCubit() : super(AttendenceInitialState());

  AttendenceRepo attendenceRepo = AttendenceRepo();

  Future<void> markAttendance({
    required String classId,
    required List<String> presentStudents,
    required List<String> absentStudents,
    required List<String> leaveStudents,
    required List<dynamic> studentNames,
    required String depName,
    required String semester,
    required String subject,
  }) async {
    emit(AttendenceLoadingState());
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      // Iterate over present students
      for (int i = 0; i < presentStudents.length; i++) {
        await attendenceRepo.markAttendance(
            userId: userId,
            classId: classId,
            studentRollNo: presentStudents[i],
            studentName: studentNames[i],
            depName: depName,
            present: true,
            absent: false,
            onLeave: false,
            semester: semester,
            subject: subject);
      }
      // Iterate over absent students
      for (int i = 0; i < absentStudents.length; i++) {
        await attendenceRepo.markAttendance(
            userId: userId,
            classId: classId,
            studentRollNo: absentStudents[i],
            studentName: studentNames[i],
            depName: depName,
            present: false,
            absent: true,
            onLeave: false,
            semester: semester,
            subject: subject);
      }
      // Iterate over leave students
      for (int i = 0; i < leaveStudents.length; i++) {
        await attendenceRepo.markAttendance(
            userId: userId,
            classId: classId,
            studentRollNo: leaveStudents[i],
            studentName: studentNames[i],
            depName: depName,
            present: false,
            absent: false,
            onLeave: true,
            semester: semester,
            subject: subject);
      }
      emit(AttendenceMarkedState());
    } catch (e) {
      emit(AttendenceErrorState(error: e.toString()));
    }
  }
}
