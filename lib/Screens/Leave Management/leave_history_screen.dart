import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/bloc/form-data/form_data_bloc.dart';
import 'package:hrm_employee/Repository/form_data_repository.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
// ignore: depend_on_referenced_packages
import 'package:nb_utils/nb_utils.dart';

import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_easy_refresh.dart';
import 'package:hrm_employee/Screens/components/others/xborder.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  late LeaveBloc leaveBloc;

  /// this is local bloc
  final formDataBloc = FormDataBloc(FormDataRepository());

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  bool isOnRefresh = false;
  bool isOnLoad = false;

  DateTime dateFilter = DateTime.now();

  @override
  void initState() {
    leaveBloc = context.read<LeaveBloc>();
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleActions(title: "Attendance History"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          10.kHeight,

          ///
          _monthYear(),

          ///
          _blocBuilder(),
        ],
      ),
    );
  }

  BlocConsumer _blocBuilder() {
    return BlocConsumer(
      bloc: leaveBloc,
      builder: (ctx, state) {
        return _kbuilder();
      },
      buildWhen: (previous, current) {
        return current.stateType == LeaveStateType.attendanceList;
      },
      listener: (ctx, state) {
        ///
        if (state.stateType == LeaveStateType.attendanceList) {
          /// is onReresh
          if (isOnRefresh) {
            if (state.attendanceListResult!.isSuccess) {
              easyRefreshController.finishRefresh(IndicatorResult.success);
            } else {
              easyRefreshController.finishRefresh(IndicatorResult.fail);
            }
            isOnRefresh = false;
          }

          /// onLoad
          if (isOnLoad) {
            ApiStatus dataStatus =
                state.attendanceListResult?.data?.dataStatus ??
                    ApiStatus.loading;

            /// success
            if (dataStatus == ApiStatus.success) {
              easyRefreshController.finishLoad(IndicatorResult.success);
            }

            /// empty
            if (dataStatus == ApiStatus.empty) {
              easyRefreshController.finishLoad(IndicatorResult.noMore);
            }

            /// error
            if (dataStatus == ApiStatus.failed) {
              easyRefreshController.finishLoad(IndicatorResult.fail);
            }
            isOnLoad = false;
          }
        }
      },
    );
  }

  Widget _kbuilder() {
    return KBuilder(
        status: leaveBloc.state.attendanceListResult!.status!,
        onRetry: () {
          _getData();
        },
        builder: (st) {
          return st == ApiStatus.loading ? Container() : _easyRefresh();
        });
  }

  Widget _easyRefresh() {
    List<InOutModel> data =
        leaveBloc.state.attendanceListResult?.data?.list ?? [];
    return Expanded(
      child: CustomEasyRefresh(
        controller: easyRefreshController,
        onRefresh: () {
          isOnRefresh = true;
          leaveBloc.add(LeaveAttendanceList(
              isLoading: false, isRefresh: true, dateFilter: dateFilter));
        },
        onLoad: () {
          isOnLoad = true;
          leaveBloc.add(LeaveAttendanceList(
              isLoading: false, isRefresh: false, dateFilter: dateFilter));
        },
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, index) {
            return _card(data[index]);
          },
        ),
      ),
    );
  }

  Row _inOut({
    required String text1,
    required String text2,
    required Color text2Color,
  }) {
    return Row(
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.blackS13W400,
        ),
        Measurement.gap.kWidth,
        Text(
          text2,
          style: Theme.of(context)
              .textTheme
              .blackS14W400
              .copyWith(color: text2Color),
        )
      ],
    );
  }

  Widget _card(InOutModel data) {
    return Container(
      padding: const EdgeInsets.only(top: Measurement.screenPadding),
      child: Material(
        elevation: 2.0,
        child: GestureDetector(
          onTap: () {
            // const DailyWorkReport().launch(context);
          },
          child: Container(
            width: context.width(),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: _borderColor(data),
                  width: 3.0,
                ),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.workHours ?? "",
                  style: Theme.of(context).textTheme.blackS14W700,
                ),
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _convertDate(
                          date: data.checkInDatetime, format: "dd MMM yyyy"),
                      style: Theme.of(context).textTheme.blackS14W700,
                    ),

                    /// Work hours
                    // if (data.checkInDatetime!.isNotEmpty &&
                    //     data.checkOutDatetime!.isNotEmpty)
                    Text(
                      data.workHours ?? "",
                      style: Theme.of(context).textTheme.greyS14W400,
                    )
                  ],
                ),
                */
                4.kHeight,
                _inOut(
                  text1: "Check In",
                  text2: _convertDate(date: data.checkInDatetime),
                  text2Color: Colors.grey,
                ),
                2.kHeight,
                _inOut(
                  text1: "Check Out",
                  text2: _convertDate(date: data.checkOutDatetime),
                  text2Color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget _monthYear() {
    return BlocBuilder<FormDataBloc, FormDataState>(
      bloc: formDataBloc,
      buildWhen: (previous, current) {
        if (current.stateType == FormDataStateType.selectDateTime) {
          return true;
        }

        return false;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: _monthPicker,
          child: Container(
            height: 40,
            alignment: Alignment.center,
            color: Colors.transparent,
            width: 160,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// month
                        /// * temp fixed using dateFilter
                        Text(
                          dateFilter.dateFormat(toFormat: "MMMM").toString(),
                          style: Theme.of(context).textTheme.blackS15W500,
                        ),
                        Measurement.gap.kWidth,

                        /// year
                        Text(
                          state.selectDateTime!.year.toString(),
                          style: Theme.of(context).textTheme.blackS15W500,
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_drop_down, size: 24)
                  ],
                ),
                6.kHeight,
                const Xborder()
              ],
            ),
          ),
        );
      },
    );
  }

  String _convertDate({String? date, String format = "yyyy-MMM-dd HH:mm"}) {
    if (date == null || date.isEmpty) {
      return "";
    }

    return DateTime.parse(date).utcToLocal(toForamt: format) ?? "";
  }

  Color _borderColor(InOutModel data) {
    if (data.checkOutDatetime!.isNotEmpty) {
      return Colors.orange;
    }
    return Colors.green;
  }

  void _getData() {
    leaveBloc.add(LeaveAttendanceList(
        isLoading: true, isRefresh: true, dateFilter: dateFilter));
  }

  Future _monthPicker() async {
    final datetime = await showMonthPicker(
      context: context,
      headerColor: AppColor.kMainColor,
      dismissible: true,
      selectedMonthBackgroundColor: Colors.purple.shade300,
      unselectedMonthTextColor: AppColor.kBlackColor,
      confirmWidget: Text(
        "OK",
        style: Theme.of(context)
            .textTheme
            .greyS15W700
            .copyWith(color: AppColor.kMainColor),
      ),
      cancelWidget: Text(
        "Cancel",
        style: Theme.of(context).textTheme.greyS15W700,
      ),
    );
    if (datetime != null) {
      /// not calling when click the same date
      if (datetime.dateFormat(toFormat: "MM-yyyy") !=
          formDataBloc.state.selectDateTime!.dateFormat(toFormat: "MM-yyyy")) {
        dateFilter = datetime;
        formDataBloc.add(FormDataSelectDateTime(datetime));
        _getData();
      }
    }
  }

  @override
  void dispose() {
    leaveBloc.add(LeaveAttendanceListDispose());
    super.dispose();
  }
}
