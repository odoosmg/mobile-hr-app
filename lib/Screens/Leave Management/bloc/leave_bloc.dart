import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Repository/leave_repository.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final LeaveRepository leaveRepository;
  LeaveBloc(this.leaveRepository) : super(LeaveInitial()) {
    on<LeaveDaySwitch>(_daySwitch);
    on<LeaveTypeListForm>(_leaveTypeListForm);
    on<LeaveDayCount>(_dayCount);
    on<LeaveSubmit>(_submit);
    on<LeaveShowFullHalf>(_showFullHalf);
  }

  ///
  void _daySwitch(LeaveDaySwitch event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.fullOrHalfDay;
    state.isHalfDay = event.isHalfDay;

    emit(state.copyWith(state));
  }

  ///
  void _leaveTypeListForm(
      LeaveTypeListForm event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.leaveTypeList;
    state.listTypeResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    ///
    await leaveRepository.leavTypeList().then((value) {
      state.listTypeResult = value;
      emit(state.copyWith(state));
    });
  }

  ///
  void _dayCount(LeaveDayCount event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.dayCount;
    double dayCount = 0.0;

    /// half day
    if (state.isHalfDay!) {
      dayCount = 0.5;
    } else {
      /// full day
      DateTime from = DateTime.parse(event.from);
      DateTime to = DateTime.parse(event.to);

      /// differnent
      int day = to.difference(from).inDays;

      if (day > 0) {
        dayCount = day.toDouble();
      } else {
        /// the same day, set as 1 day
        if (to.isAtSameMomentAs(from)) {
          dayCount = 1;
        } else {
          dayCount = 0.0;
        }
      }
    }
    state.dayCount = dayCount;
    emit(state.copyWith(state));
  }

  ///
  void _submit(LeaveSubmit event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.submit;
    state.submitLeaveResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    ///
    await leaveRepository.requestLeave(event.params).then((value) {
      state.submitLeaveResult = value;
      emit(state.copyWith(state));
    });
  }

  ///
  void _showFullHalf(LeaveShowFullHalf event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.isShowFullHalf;
    state.isShowSelectFullHalf = event.isShow;

    emit(state.copyWith(state));
  }
}
