import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scavenger_app/Repositories/student_repo.dart';
import 'package:scavenger_app/bloc/Student-cubit/students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(StudentsInitialState());
  final StudentRepo studentRepo = StudentRepo();

  Future<void> addStudent(String classId, String rollno, String name,
      String department, String semester, String subject) async {
    emit(StudentsLoadingState());
    try {
      // Get the current user's ID
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("No user is currently logged in.");
      }
      String userId = currentUser.uid;

      await studentRepo.addStudent(
          userId, classId, rollno, name, department, semester, subject);
      emit(StudentsAddedState());
    } catch (e) {
      emit(StudentsErrorState(error: e.toString()));
    }
  }

  Future<void> getStudents(String classId) async {
    emit(StudentsLoadingState());
    try {
      var students = await studentRepo.getStudentsByClass(classId);
      emit(StudentsLoadedState(students: students));
    } catch (e) {
      emit(StudentsErrorState(error: e.toString()));
    }
  }

  Future<void> getStudentsBySemesterAndDepartment(
      String semester, String department, String subject) async {
    emit(StudentsLoadingState());
    try {
      var students = await studentRepo.getStudentsBySemesterAndDepartment(
          semester, department, subject);
      emit(StudentsLoadedState(students: students));
    } catch (e) {
      emit(StudentsErrorState(error: e.toString()));
    }
  }
}
