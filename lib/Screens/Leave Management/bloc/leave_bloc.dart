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

    on<LeaveMyList>(_myLeaveList);
    on<LeaveToApproveList>(_toApproveList);

    on<LeaveAction>(_leaveAction);
    // on<LeaveShowFullHalf>(_showFullHalf);
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
        /// +1, cuz on Fullday dateFrom count as 1.
        /// so if pick current day and next day it will count as 2.
        dayCount = day.toDouble() + 1;

        /// the same day is 1
        if (to.isAtSameMomentAs(from)) {
          dayCount = 1;
        }
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

  /// request leave
  void _submit(LeaveSubmit event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.submit;
    state.submitLeaveResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    ///
    await leaveRepository.requestLeave(event.params).then((value) async {
      if (value.isSuccess) {
        /// use delay when emit multi state the same time
        await Future.delayed(const Duration(seconds: 0)).then((_) {
          final p = event.params;
          p.state = 'To Approve'; // status pending
          p.numberOfDays = value.data?.numberOfDays ?? 0;

          /// get type name
          p.leaveTypeName = (state.listTypeResult?.data?.leaveTypeList ?? [])
                  .where((e) => e.id == p.leaveTypeId)
                  .firstOrNull
                  ?.name ??
              "";

          /// add item to list
          state.myLeaveListResult!.data!.list!.insert(0, p);
          state.stateType = LeaveStateType.myLeaveList;
          emit(state.copyWith(state));
        });
      }

      ///
      await Future.delayed(const Duration(seconds: 0)).then((_) {
        state.stateType = LeaveStateType.submit;
        state.submitLeaveResult = value;
        emit(state.copyWith(state));
      });
    });
  }

  ///
  void _myLeaveList(LeaveMyList event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.myLeaveList;
    if (event.isLoading) {
      state.myLeaveListResult!.status = ApiStatus.loading;
    }
    emit(state.copyWith(state));

    ///
    await leaveRepository.myList().then((value) {
      state.myLeaveListResult = value;
      emit(state.copyWith(state));
    });
  }

  ///
  void _toApproveList(
      LeaveToApproveList event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.toApproveList;
    if (event.isLoading) {
      state.toApproveListResult!.status = ApiStatus.loading;
    }
    emit(state.copyWith(state));

    ///
    await leaveRepository.toApproveList().then((value) async {
      state.toApproveListResult = value;
      emit(state.copyWith(state));
    });
  }

  ///
  void _leaveAction(LeaveAction event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.leaveAction;
    state.leaveActionResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    await leaveRepository.leaveAction(0, "").then((value) async {
      ///
      if (value.isSuccess) {
        /// Update item at my List. Append new item
        if (event.status == LeaveStatus.approved) {
          event.data.state = LeaveStatus.approved.name;
        } else {
          event.data.state = LeaveStatus.refused.name;
        }

        state.myLeaveListResult!.data!.list!.insert(0, event.data);
        state.stateType = LeaveStateType.myLeaveList;
        emit(state.copyWith(state));

        /// update item at To Approve List. Remove item
        if (state.toApproveListResult!.data!.toApprovedList!.isNotEmpty) {
          await Future.delayed(Duration.zero);
          state.toApproveListResult!.data!.toApprovedList!
              .removeAt(event.index);
          state.stateType = LeaveStateType.toApproveList;
          emit(state.copyWith(state));
        }
      }

      /// Current Action
      await Future.delayed(Duration.zero);
      state.stateType = LeaveStateType.leaveAction;
      state.leaveActionResult = value;
      emit(state.copyWith(state));
    });
  }
  // @override
  // void onChange(Change<LeaveState> change) {
  //   // TODO: implement onChange
  //   super.onChange(change);
  // }

  // ///
  // void _showFullHalf(LeaveShowFullHalf event, Emitter<LeaveState> emit) async {
  //   state.stateType = LeaveStateType.isShowFullHalf;
  //   state.isShowSelectFullHalf = event.isShow;

  //   emit(state.copyWith(state));
  // }
}
