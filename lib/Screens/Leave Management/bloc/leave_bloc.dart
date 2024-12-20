import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Repository/leave_repository.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/extensions/date_extension.dart';

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
    on<LeaveListScreenDispose>(_leaveListScreenDispose);
    on<LeaveInitialDayCount>(_initialDayCount);
    on<LeaveAttendanceList>(_attendanceList);
    on<LeaveAttendanceListDispose>(_attendanceListDispose);
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
    final holidays =
        AppServices.instance<DatabaseService>().getPublicHoliday?.list ?? [];

    double dayCount = 0.0;

    DateTime from = DateTime.parse(event.from);
    DateTime to = DateTime.parse(event.to);

    /// half day
    if (state.isHalfDay!) {
      dayCount = 0.5;
    } else {
      /// full day
      /// different
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

    /// ** calciulate with holidays **
    if (holidays.isNotEmpty) {
      int totalHolidays = 0;

      /// loop all in dayCount
      for (int i = 1; i < dayCount.toInt(); i++) {
        /// increase day follow by dayCount
        DateTime dateIncrease = from.add(Duration(days: i));
        List<String> holidayInMonth =
            holidays[dateIncrease.month - 1].getListStrDates();

        /// if date increase contain holiday
        if (holidayInMonth
            .contains(dateIncrease.dateFormat(toFormat: "yyyy-MM-dd"))) {
          totalHolidays += 1;
        }

        /// if Sunday
        // if (dateIncrease.weekday == 7) {
        //   totalHolidays += 1;
        // }
      }

      /// Halfdat and Holiday
      if (dayCount == 0.5) {
        if (holidays[from.month - 1]
            .getListStrDates()
            .contains(from.dateFormat(toFormat: "yyyy-MM-dd"))) {
          dayCount = 0;
        }
      }
      dayCount = dayCount - totalHolidays;
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
      /// is success
      if (value.isSuccess) {
        /// use delay when emit multi state the same time
        await Future.delayed(const Duration(seconds: 0));
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
        /// ??= mean if null equal
        state.myLeaveListResult?.data ??= LeaveModel()..list = [];
        state.myLeaveListResult!.data!.list!.insert(0, p);
        state.stateType = LeaveStateType.myLeaveList;
        emit(state.copyWith(state));
/*
          /// approver = false
          if (!AppServices.instance<DatabaseService>()
              .getPermissoin!
              .leave!
              .isApprover!) {
            state.myLeaveListResult!.data!.list!.insert(0, p);
            state.stateType = LeaveStateType.myLeaveList;
            emit(state.copyWith(state));
          } else {
            /// approver = true
            List<int> companyIds =
                AppServices.instance<DatabaseService>().getCompanyIds!;
            int currentUserComapnyId = 1; // Update later

            /// append when have company id in filter
            if (companyIds.contains(currentUserComapnyId)) {
              /// id
              p.id = value.data?.id ?? 0;

              /// name
              p.employeeName = AppServices.instance<DatabaseService>()
                      .getSession
                      ?.myProfile
                      ?.name ??
                  "";
              state.toApproveListResult!.data!.toApprovedList!.insert(0, p);
              state.stateType = LeaveStateType.toApproveList;
              await Future.delayed(const Duration(seconds: 0));
              emit(state.copyWith(state));
            }
          }
*/
      }

      ///
      await Future.delayed(const Duration(seconds: 0));
      state.stateType = LeaveStateType.submit;
      state.submitLeaveResult = value;
      emit(state.copyWith(state));
    });
  }

  ///
  void _myLeaveList(LeaveMyList event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.myLeaveList;

    /// only rebuild
    if (event.isRebuild) {
      await Future.delayed(Duration.zero);
      emit(state.copyWith(state));
      return;
    }

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

    /// only rebuild
    if (event.isRebuild) {
      await Future.delayed(Duration.zero);
      emit(state.copyWith(state));
      return;
    }
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

    await leaveRepository
        .leaveAction(event.data.id ?? 0, event.status.keyword)
        .then((value) async {
      ///
      if (value.isSuccess) {
        /*
        /// Append to list if current current UserId = employeeId
        if (AppServices.instance<DatabaseService>().getSession!.myProfile!.id ==
            event.data.employeeId) {
          /// Update item at my List. Append new item
          if (event.status == LeaveStatus.approved) {
            event.data.state = LeaveStatus.approved.name;
          } else {
            event.data.state = LeaveStatus.refused.name;
          }

          state.myLeaveListResult!.data!.list!.insert(0, event.data);
          state.stateType = LeaveStateType.myLeaveList;

          emit(state.copyWith(state));
        }
        */

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

  ///
  void _initialDayCount(
      LeaveInitialDayCount event, Emitter<LeaveState> emit) async {
    final holidays =
        AppServices.instance<DatabaseService>().getPublicHoliday?.list ?? [];

    /// if today is holiday 0
    if (holidays.isNotEmpty) {
      if (holidays[DateTime.now().month - 1]
          .getListStrDates()
          .contains(DateTime.now().dateFormat(toFormat: "yyyy-MM-dd"))) {
        state.dayCount = 0;
        return;
      }
    }
    state.dayCount = 1;
  }

  ///
  void _attendanceList(
      LeaveAttendanceList event, Emitter<LeaveState> emit) async {
    state.stateType = LeaveStateType.attendanceList;
    int page = 0;

    if (event.isLoading) {
      state.attendanceListResult!.status = ApiStatus.loading;
      emit(state.copyWith(state));
    }

    /// onLoad , + 10
    if (!event.isRefresh) {
      page = (state.attendanceListResult?.data?.page ?? 0) + 10;
    }

    // await Future.delayed(Duration(seconds: 3));

    /// first day, last day
    /// format yyyy-MM-dd
    final dateFilter = event.dateFilter;
    final firstDay = "${dateFilter.dateFormat(toFormat: "yyyy-MM")}-01";
    final lastDay = DateTime(dateFilter.year, dateFilter.month + 1, 0)
        .dateFormat(toFormat: "yyyy-MM-dd")
        .toString();

    ///
    await leaveRepository
        .attendanceList(page: page, from: firstDay, to: lastDay)
        .then((value) {
      state.attendanceListResult!.data!.dataStatus = value.status;

      if (event.isRefresh) {
        state.attendanceListResult = value;

        if (value.isSuccess && value.data!.list!.isEmpty) {
          state.attendanceListResult!.status = ApiStatus.empty;
        }
      } else {
        if (value.isSuccess) {
          /// update page
          state.attendanceListResult!.data!.page = value.data!.page;

          /// on load add more record.
          if (value.data!.list!.isNotEmpty) {
            state.attendanceListResult!.data!.list!.addAll(value.data!.list!);
          } else {
            state.attendanceListResult!.data!.dataStatus = ApiStatus.empty;
          }
        }
      }

      emit(state.copyWith(state));
    });
  }

  ///
  void _leaveListScreenDispose(
      LeaveListScreenDispose event, Emitter<LeaveState> emit) async {
    state.myLeaveListResult?.data = LeaveModel();
    state.myLeaveListResult!.status = ApiStatus.loading;
    state.toApproveListResult?.data = LeaveModel();
    state.toApproveListResult!.status = ApiStatus.loading;
  }

  void _attendanceListDispose(
      LeaveAttendanceListDispose event, Emitter<LeaveState> emit) {
    state.attendanceListResult!.data!.list = [];
    state.attendanceListResult!.status = ApiStatus.loading;
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
