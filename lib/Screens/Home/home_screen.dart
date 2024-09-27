// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_easy_refresh.dart';
import 'package:hrm_employee/Screens/components/pages/home/attendance_list_card.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_loading.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Screens/Authentication/bloc/auth_bloc.dart';
import 'package:hrm_employee/Screens/Authentication/profile_screen.dart';
import 'package:hrm_employee/Screens/Authentication/sign_in.dart';
import 'package:hrm_employee/Screens/Chat/chat_list.dart';
import 'package:hrm_employee/Screens/Employee%20Directory/employee_directory_screen.dart';
import 'package:hrm_employee/Screens/Home/bloc/home_bloc.dart';
import 'package:hrm_employee/Screens/Home/date_label_cubit/date_label_cubit.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_management_screen.dart';
import 'package:hrm_employee/Screens/Loan/loan_list.dart';
import 'package:hrm_employee/Screens/Notice%20Board/notice_list.dart';
import 'package:hrm_employee/Screens/Notification/notification_screen.dart';
import 'package:hrm_employee/Screens/Outwork%20Submission/outwork_list.dart';
import 'package:hrm_employee/Screens/Salary%20Management/salary_statement_list.dart';
import 'package:hrm_employee/Screens/Work%20Report/daily_work_report.dart';
import 'package:hrm_employee/Screens/components/pages/home/in_out_card.dart';
import 'package:hrm_employee/Screens/components/pages/home_drawer.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/extensions/date_extension.dart';

import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../GlobalComponents/button_global.dart';
import '../../GlobalComponents/purchase_model.dart';
import '../../constant.dart';
import '../Attendance Management/management_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Session? session;

  ///
  final EasyRefreshController easyRefreshController =
      EasyRefreshController(controlFinishRefresh: true);

  late HomeBloc homeBloc;

  ///
  String? checkInDateLabel;
  String? checkOutDatelabel;

  /// Btn status
  AttendanceInOutStatus inOutStatus = AttendanceInOutStatus.checkIn;

  String? checkInTime, checkOutTime;

  /// to not conflicting with initState
  bool isOnRefresh = false;

  @override
  void initState() {
    /// from local
    session = AppServices.instance<DatabaseService>().getSession;
    homeBloc = context.read<HomeBloc>();

    /// get data
    homeBloc.add(HomeGetData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: ListTile(
          contentPadding: EdgeInsets.zero,

          /// profile photo
          leading: CircleAvatar(
            radius: 20.0,
            backgroundImage:
                MemoryImage(base64Decode(session?.myProfile?.image ?? "")),
          ),

          /// name
          title: Text(
            'Hi, ${session?.myProfile?.name}',
            style: kTextStyle.copyWith(color: Colors.white, fontSize: 12.0),
          ),

          /// Company
          subtitle: Text(
            '${session?.myProfile?.company}',
            style: kTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: const HomeDrawer(),

      /// ** Bloc
      body: BlocBuilder<HomeBloc, HomeState>(buildWhen: (previous, current) {
        ///
        if (current.stateType == HomeStateType.getData) {
          ///
          if (isOnRefresh) {
            _onRefreshState();
            isOnRefresh = false;
          } else {
            _onRefreshState();
          }

          return true;
        }

        return false;
      }, builder: (context, state) {
        return _body();
      }),
    );
  }

  Widget _kBuilder() {
    return KBuilder(
        status: homeBloc.state.getDataResult!.status!,
        builder: (st) {
          return st == ApiStatus.loading ? Container() : _easyRefresh();
        });
  }

  Widget _easyRefresh() {
    return CustomEasyRefresh(
      controller: easyRefreshController,
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Check in-out
            ..._inOut(),

            /// Attendance List
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 24),
              child: AttendanceListCard(
                data: homeBloc.state.getDataResult?.data ?? InOutModel(),
              ),
            ),

            const SizedBox(
              height: 20.0,
            ),

            ..._gridMenu(),

            const SizedBox(
              height: 20.0,
            ),
            // ..._options()
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Container(
              padding: const EdgeInsets.only(
                left: Measurement.screenPadding,
                right: Measurement.screenPadding,
              ),
              // width: double.infinity,

              height: Measurement.heightPercent(context, 0.87),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: _kBuilder())
        ],
      ),
    );
  }

  List<Widget> _options() {
    return [
      Material(
        elevation: 2.0,
        child: Container(
          width: context.width(),
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFFFD72AF),
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: ListTile(
            onTap: () {
              const SalaryStatementList().launch(context);
            },
            leading:
                const Image(image: AssetImage('images/salarymanagement.png')),
            title: Text(
              'Salary Statement',
              maxLines: 2,
              style: kTextStyle.copyWith(
                  color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Material(
        elevation: 2.0,
        child: Container(
          width: context.width(),
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF1CC389),
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: ListTile(
            onTap: () => const NoticeList().launch(context),
            leading: const Image(image: AssetImage('images/noticeboard.png')),
            title: Text(
              'Notice Board',
              maxLines: 2,
              style: kTextStyle.copyWith(
                  color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Material(
        elevation: 2.0,
        child: Container(
          width: context.width(),
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF7C69EE),
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: ListTile(
            onTap: () => const OutworkList().launch(context),
            leading:
                const Image(image: AssetImage('images/outworksubmission.png')),
            title: Text(
              'Outwork Submission',
              maxLines: 2,
              style: kTextStyle.copyWith(
                  color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Material(
        elevation: 2.0,
        child: Container(
          width: context.width(),
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF4ACDF9),
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: ListTile(
            onTap: () => const LoanList().launch(context),
            leading: const Image(image: AssetImage('images/loan.png')),
            title: Text(
              'Loan',
              maxLines: 2,
              style: kTextStyle.copyWith(
                  color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    ];
  }

  List<Widget> _gridMenu() {
    return [
      Row(
        children: [
          Expanded(
            child: Material(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () async {
                  bool isValid = await PurchaseModel().isActiveBuyer();
                  if (isValid) {
                    const EmployeeManagement().launch(context);
                  } else {
                    showLicense(context: context);
                  }
                },
                child: Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFFFD72AF),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(
                          image: AssetImage('images/employeeattendace.png')),
                      Text(
                        'Employee',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Attendance',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Material(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () {
                  const EmployeeDirectory().launch(context);
                },
                child: Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF7C69EE),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(
                          image: AssetImage('images/employeedirectory.png')),
                      Text(
                        'Employee',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Directory',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20.0,
      ),
      Row(
        children: [
          Expanded(
            child: Material(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () {
                  const LeaveManagementScreen().launch(context);
                },
                child: Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF4ACDF9),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(image: AssetImage('images/leave.png')),
                      Text(
                        'Leave',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Application',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Material(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () {
                  const DailyWorkReport().launch(context);
                },
                child: Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF02B984),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(image: AssetImage('images/workreport.png')),
                      Text(
                        'Daily Work',
                        maxLines: 2,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Report',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _inOut() {
    return [
      ///
      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) {
          final checkinResult = current.checkInResult!;

          /// check-in
          if (current.stateType == HomeStateType.checkin) {
            return _checkInState(checkinResult);
          }
          return false;
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: InOutCard(
              checkinDate: checkInTime,
              checkoutDate: checkOutTime,
              onSubmit: (st) {
                if (st == AttendanceInOutStatus.checkIn) {
                  homeBloc.add(HomeCheckIn());
                }
              },
              status: inOutStatus,
            ),
          );
        },
      ),
    ];
  }

  /// Snackbar
  void _checkInOutSnackbar(bool isCheckIn, String date) {
    Flushbar(
      // isDismissible: false,
      backgroundColor: AppColor.kWhiteColor,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      titleText: Icon(
        isCheckIn ? Icons.login : Icons.logout,
        color: Colors.black,
        size: 24,
      ),
      messageText: Text(
        isCheckIn ? "Check in, $date" : "Check out, $date",
        style: Theme.of(context).textTheme.blackS13W700,
        textAlign: TextAlign.center,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
    ).show(context);
  }

  ///****************************************************
  ///
  ///****************************************************/

  String _utcToLocal(String? d) {
    if (d == null || d.isEmpty) {
      return "";
    }

    /// utc to  local
    DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(d, true).toLocal();
    return date
        .dateFormat(currentFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "HH:mm")
        .toString();
  }

  void _onRefreshState() {
    /// response
    ApiResult<InOutModel> res = homeBloc.state.getDataResult!;

    if (res.isSuccess) {
      InOutModel data = res.data ?? InOutModel();

      InOutModel latestCheckIn = data.latestCheckIn ?? InOutModel();
      InOutModel latestCheckOut = data.latestCheckOut ?? InOutModel();

      /// checkId = 0, button is checkin
      if ((data.latestCheckIn?.checkInId ?? 0) == 0) {
        inOutStatus = AttendanceInOutStatus.checkIn;

        /// if have check-in time, display
        checkInTime = (latestCheckOut.checkInDatetime ?? "").isEmpty
            ? null
            : _utcToLocal(latestCheckOut.checkInDatetime!);
        checkOutTime = (latestCheckOut.checkOutDatetime ?? "").isEmpty
            ? null
            : _utcToLocal(latestCheckOut.checkOutDatetime ?? "");
      } else {
        /// else button checkout
        checkInTime = (latestCheckIn.checkInDatetime ?? "").isEmpty
            ? null
            : _utcToLocal(latestCheckIn.checkInDatetime ?? "");

        checkOutTime = (latestCheckOut.checkOutDatetime ?? "").isEmpty
            ? null
            : _utcToLocal(latestCheckOut.checkOutDatetime ?? "");

        /// update checkin id
        // homeController.checkInResult.data!.checkInId =
        //     data.latestCheckIn?.checkInId ?? 0;

        /// update status
        inOutStatus = AttendanceInOutStatus.checkOut;
      }

      easyRefreshController.finishRefresh(IndicatorResult.success);
    } else {
      /// failed
      return easyRefreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void _onRefresh() async {
    isOnRefresh = true;
    homeBloc.add(HomeGetData(isLoading: false));
  }

  ///
  bool _checkInState(ApiResult<InOutModel> response) {
    if (response.status == ApiStatus.loading) {
      CustomLoading.show(context);
    } else {
      CustomLoading.hide(context);

      /// Success
      if (response.isSuccess) {
        /// update label
        checkInTime =
            _utcToLocal((response.data?.checkInDatetime ?? "").trim());
        inOutStatus = AttendanceInOutStatus.checkOut;

        /// display snackbar
        _checkInOutSnackbar(true, checkInTime!);

        return true; // re-build
      } else {
        /// failed
        CustomDialog.error(
          context,
          errCode: response.statuscode,
          errMsg: response.errorMessage,
        );
      }
    }
    return false;
  }

  @override
  void dispose() {
    homeBloc.state.getDataResult!.data = InOutModel();
    homeBloc.state.getDataResult!.status = ApiStatus.loading;

    homeBloc.state.checkInResult!.data = InOutModel();
    homeBloc.state.checkInResult!.status = ApiStatus.loading;
    super.dispose();
  }
}
