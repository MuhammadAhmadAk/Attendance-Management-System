abstract class RecordsState {}

class RecordsInitialState extends RecordsState {}

class RecordsLoadingState extends RecordsState {}

class RecordsLoadedState extends RecordsState {
  final List<Map<String, dynamic>> record;

  RecordsLoadedState(this.record);
}

class RecordsErrorState extends RecordsState {
  final String error;

  RecordsErrorState(this.error);
}
