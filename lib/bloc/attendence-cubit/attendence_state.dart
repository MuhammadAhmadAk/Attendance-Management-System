class AttendenceState {}

final class AttendenceInitialState extends AttendenceState {}

class AttendenceMarkedState extends AttendenceState {}

class AttendenceLoadingState extends AttendenceState {}

class AttendenceErrorState extends AttendenceState {
  final String error;

  AttendenceErrorState({required this.error});
}
