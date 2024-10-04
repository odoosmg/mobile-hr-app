part of 'leave_bloc.dart';

class LeaveState {
  LeaveStateType? stateType;
  bool? isHalfDay;

  LeaveState({
    this.stateType,
    this.isHalfDay,
  });

  LeaveState copyWith(LeaveState d) {
    return LeaveState(
      stateType: d.stateType,
      isHalfDay: d.isHalfDay,
    );
  }
}

final class LeaveInitial extends LeaveState {
  @override
  bool? get isHalfDay => false;
}

enum LeaveStateType {
  fullAndHalfDay,
}
