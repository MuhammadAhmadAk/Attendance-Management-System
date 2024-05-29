class StudentsState {}

final class StudentsInitialState extends StudentsState {}

class StudentsLoadingState extends StudentsState {}

class StudentsAddedState extends StudentsState {}

class StudentsLoadedState extends StudentsState {
  final List<Map<String, dynamic>> students;
  StudentsLoadedState({required this.students});
}

class StudentsErrorState extends StudentsState {
  final String error;

  StudentsErrorState({required this.error});
}
