import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_app/bloc/DepartmentId-cubit/department_state.dart';

import '../../Repositories/departments_repo.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitialState());

  DepartmentRepo departmentRepo = DepartmentRepo();
  Future<void> addDepartment(
      String subject, String department, String semester) async {
    emit(DepartmentLoadingState());
    try {
      await departmentRepo.addDepartment(department, semester, subject);
      emit(DepartmentAddedState());
    } catch (e) {
      emit(DepartmentErrorState(error: e.toString()));
    }
  }

  Future<void> getDepartment() async {
    emit(DepartmentLoadingState());
    try {
      var Department = await departmentRepo.getDepartments();
      emit(DepartmentLoadedState(Department: Department));
    } catch (e) {
      emit(DepartmentErrorState(error: e.toString()));
    }
  }
}
