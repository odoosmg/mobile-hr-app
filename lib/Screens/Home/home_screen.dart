// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
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
  Timer? timer;

  final dateLabelCubit = DateLabelCubit();

  late HomeBloc homeBloc;

  ///
  String? checkInDateLabel;
  String? checkOutDatelabel;

  @override
  void initState() {
    /// from local
    session = AppServices.instance<DatabaseService>().getSession;
    homeBloc = context.read<HomeBloc>();

    ///
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      // context.read<HomeBloc>().add(DateLabel(DateTime.now()));
      dateLabelCubit.dateLabel();
    });

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
      body: BlocBuilder<HomeBloc, HomeState>(buildWhen: (previous, current) {
        ///
        if (current.stateType == HomeStateType.getData) {
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
          return st == ApiStatus.loading
              ? Container()
              : Column(
                  children: [
                    ..._inOut(),

                    const SizedBox(
                      height: 20.0,
                    ),

                    ..._gridMenu(),

                    const SizedBox(
                      height: 20.0,
                    ),
                    // ..._options()
                  ],
                );
        });
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
              padding: const EdgeInsets.all(20.0),
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
      /// * Bloc
      /// Date Label
      BlocBuilder<DateLabelCubit, DateTime>(
        bloc: dateLabelCubit,
        builder: (context, state) {
          return Column(
            children: [
              /// Date
              Text(
                state.dateFormat(toFormat: "EEEE, MMM dd, yyyy").toString(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              const SizedBox(
                height: 10.0,
              ),

              /// Time
              Text(
                '${state.dateFormat(toFormat: "H:mm")}',
                style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            ],
          );
        },
      ),

      /// ************

      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: InOutCard(
          checkinDate: checkInDateLabel,
          // checkoutDate: "10-10-2024",
          onSubmit: (st) {},
          status: AttendanceInOutStatus.checkIn,
        ),
      ),

      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previousSte, currentState) {
          final checkinResult = currentState.checkInResult!;
          if (currentState.stateType != HomeStateType.checkin) {
            return false;
          }
          if (checkinResult.status == ApiStatus.loading) {
            CustomLoading.show(context);
          } else {
            CustomLoading.hide(context);

            /// Failed
            if (!checkinResult.isSuccess) {
              CustomDialog.error(
                context,
                errCode: checkinResult.statuscode,
                errMsg: checkinResult.errorMessage,
              );
            } else {
              // checkInDateLabel = currentState.checkInResult.data.checkInDatetime
            }
          }

          return false;
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: true
                  ? kGreenColor.withOpacity(0.1)
                  : kAlertColor.withOpacity(0.1),
            ),
            child: GestureDetector(
              onTap: () {
                homeBloc.add(HomeCheckIn());
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const NewAttendenceReport()));
              },
              child: CircleAvatar(
                radius: 70.0,
                backgroundColor: true ? kGreenColor : kAlertColor,
                child: Text(
                  true ? 'Check In' : 'Check Out',
                  style: kTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    ];
  }

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

  @override
  void dispose() {
    timer!.cancel();
    homeBloc.state.getDataResult!.data = InOutModel();
    homeBloc.state.getDataResult!.status = ApiStatus.loading;

    homeBloc.state.checkInResult!.data = InOutModel();
    homeBloc.state.checkInResult!.status = ApiStatus.loading;
    super.dispose();
  }
}
