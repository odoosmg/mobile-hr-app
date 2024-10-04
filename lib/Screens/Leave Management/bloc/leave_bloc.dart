import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Repository/leave_repository.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final LeaveRepository leaveRepository;
  LeaveBloc(this.leaveRepository) : super(LeaveInitial()) {
    on<LeaveDaySwitch>(_daySwitch);
    on<LeaveTypeListForm>(_leaveTypeListForm);
  }

  void _daySwitch(LeaveDaySwitch event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.fullAndHalfDay;
    state.isHalfDay = event.isFullday;
    emit(state.copyWith(state));
  }

  void _leaveTypeListForm(
      LeaveTypeListForm event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.leaveTypeList;
    state.listTypeResult!.status = ApiStatus.loading;
    await leaveRepository.leavTypeList().then((value) {
      state.listTypeResult = value;
    });

    emit(state.copyWith(state));
  }
}
