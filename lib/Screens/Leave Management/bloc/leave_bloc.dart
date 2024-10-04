import 'package:flutter_bloc/flutter_bloc.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial()) {
    on<LeaveDaySwitch>(_daySwitch);
  }

  void _daySwitch(LeaveDaySwitch event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.fullAndHalfDay;
    state.isHalfDay = event.isFullday;
    emit(state.copyWith(state));
  }
}
