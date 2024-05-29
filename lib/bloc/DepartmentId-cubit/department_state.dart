class DepartmentState {}

final class DepartmentInitialState extends DepartmentState {}

final class DepartmentAddedState extends DepartmentState {}

final class DepartmentLoadingState extends DepartmentState {}

final class DepartmentLoadedState extends DepartmentState {
  final List<Map<String, dynamic>> Department;

  DepartmentLoadedState({required this.Department});
}

final class DepartmentErrorState extends DepartmentState {
  final String error;

  DepartmentErrorState({required this.error});
}
