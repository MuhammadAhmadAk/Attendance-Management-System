import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_app/Repositories/attendence_repo.dart';
import 'package:scavenger_app/bloc/attendent-records/records_state.dart';

class RecordsCubit extends Cubit<RecordsState> {
  RecordsCubit() : super(RecordsInitialState());
  AttendenceRepo attendenceRepo = AttendenceRepo();
  Future<void> getRecords({
    required String depName,
    required String semester,
    required String subject,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
  }) async {
    try {
      var record = await attendenceRepo.getAttendanceRecordsWithinDateRange(
          depName: depName,
          semester: semester,
          subject: subject,
          startDate: startDate,
          endDate: endDate,
          status: status);
      print("record:$record");
      emit(RecordsLoadedState(record));
    } catch (e) {
      emit(RecordsErrorState(e.toString()));
    }
  }
}
