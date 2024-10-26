// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';

import 'package:hrm_employee/Screens/components/pages/home/select-company/ui/select_company.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_easy_refresh.dart';
import 'package:hrm_employee/Screens/components/pages/home/attendance_list_card.dart';
import 'package:hrm_employee/Screens/components/pages/home/attendance_static_chart.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/Screens/Home/ui/menu_screen.dart';
import 'package:hrm_employee/Screens/components/others/body_card.dart';
import 'package:hrm_employee/Screens/components/others/profile_bar_listener.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_loading.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/auth/session.dart';

import 'package:hrm_employee/Screens/Home/bloc/home_bloc.dart';
import 'package:hrm_employee/Screens/Loan/loan_list.dart';
import 'package:hrm_employee/Screens/Notice%20Board/notice_list.dart';
import 'package:hrm_employee/Screens/Outwork%20Submission/outwork_list.dart';
import 'package:hrm_employee/Screens/Salary%20Management/salary_statement_list.dart';
import 'package:hrm_employee/Screens/components/pages/home/in_out_card.dart';
import 'package:hrm_employee/Screens/components/pages/home_drawer.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/extensions/date_extension.dart';

import 'package:hrm_employee/utlis/app_color.dart';

import '../../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///
  final EasyRefreshController easyRefreshController =
      EasyRefreshController(controlFinishRefresh: true);

  late Session? session;
  late HomeBloc homeBloc;

  /// Btn status
  AttendanceInOutStatus inOutStatus = AttendanceInOutStatus.checkIn;

  String? checkInTime, checkOutTime;

  /// to not conflicting with initState
  bool isOnRefresh = false;

  /// for display SelectCompany
  bool isLoadSuccess = false;

  int checkInId = 0;

  @override
  void initState() {
    /// from local
    session = AppServices.instance<DatabaseService>().getSession;
    homeBloc = context.read<HomeBloc>();

    _initOrRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        toolbarHeight: 75,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: ProfileBarListener(
          builder: (ses) {
            return ListTile(
              contentPadding: EdgeInsets.zero,

              /// profile photo
              leading: CircleAvatar(
                radius: 20.0,
                backgroundImage:
                    MemoryImage(base64Decode(session?.myProfile?.image ?? "")),
              ),

              /// name
              title: Text(
                'Hi, ${ses.myProfile?.name}',
                style: kTextStyle.copyWith(color: Colors.white, fontSize: 12.0),
              ),
/*
              /// Company
              subtitle: Text(
                '${session?.myProfile?.company}',
                maxLines: 1,
                style: kTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
*/
            );
          },
        ),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) {
              if (current.stateType == HomeStateType.getData) {
                if (current.getDataResult!.status != ApiStatus.loading) {
                  isLoadSuccess = true;
                  return true;
                }
              }
              return false;
            },
            builder: (context, state) {
              return !isLoadSuccess
                  ? Container()
                  : SelectCompany(
                      onRefresh: (_) {},
                      // key: ValueKey(isLoadSuccess),
                      onChanged: (ids, _) {
                        homeBloc.add(HomeGetData());
                      },
                    );
            },
          ),
        ],
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       const MenuScreen().launch(context);
        //     },
        //     child: const Padding(
        //       padding: EdgeInsets.only(right: 10),
        //       child: SizedBox(
        //         height: 50,
        //         width: 50,
        //         // color: Colors.red,
        //         child: Icon(
        //           Icons.widgets,
        //           color: Colors.white,
        //           size: 24,
        //         ),
        //       ),
        //     ),
        //   )
        // ],
      ),
      drawer: const HomeDrawer(),

      ///
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kMainColor,
        onPressed: () {
          const MenuScreen().launch(context);
        },
        child: const Icon(Icons.widgets, color: AppColor.kWhiteColor),
      ),

      /// ** Bloc
      body: BodyCard(
        child: BlocBuilder<HomeBloc, HomeState>(buildWhen: (previous, current) {
          ///
          if (current.stateType == HomeStateType.getData) {
            /// prevent onRefresh and initState
            /// * fixed build oldState then newState
            if (isOnRefresh) {
              isOnRefresh = false;

              /// _onRefrsh. status.loaoding should not rebuild,
              /// need this condition cuz of state fire 2 times
              return false;
            } else {
              _onRefreshState();
            }

            return true;
          }

          return false;
        }, builder: (context, state) {
          return _kBuilder();
        }),
      ),
    );
  }

  Widget _kBuilder() {
    return KBuilder(
        status: homeBloc.state.getDataResult!.status!,
        errorMessage: homeBloc.state.getDataResult!.errorMessage,
        onRetry: () {
          homeBloc.add(HomeGetData());
        },
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

            /// Chart
            const AttendanceStaticChart(),

            10.height,

            // ..._gridMenu(),

            // 10.height,

            // ..._options()
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: _kBuilder(),
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

  List<Widget> _inOut() {
    return [
      /// ** Bloc
      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) {
          /// check-in
          if (current.stateType == HomeStateType.checkin) {
            return _checkInState(current.checkInResult!);
          }

          /// check-out
          if (current.stateType == HomeStateType.checkout) {
            return _checkOutState(current.checkOutResult!);
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
                } else {
                  homeBloc.add(HomeCheckOut(checkInId: checkInId));
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
  /// true = checkin, false = checkout
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

        /// update checkIn id
        checkInId = data.latestCheckIn?.checkInId ?? 0;

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
    _initOrRefresh();
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

        ///
        checkInId = response.data?.checkInId ?? 0;

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

  ///
  bool _checkOutState(ApiResult<InOutModel> response) {
    if (response.status == ApiStatus.loading) {
      CustomLoading.show(context);
    } else {
      CustomLoading.hide(context);

      /// Success
      if (response.isSuccess) {
        /// update label
        checkOutTime =
            _utcToLocal((response.data?.checkOutDatetime ?? "").trim());

        ///
        inOutStatus = AttendanceInOutStatus.checkIn;

        /// display snackbar
        _checkInOutSnackbar(false, checkOutTime!);

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

  /// Where initial, and onRfresh
  void _initOrRefresh() {
    homeBloc.add(HomeGetCurrentAndNextYear());
    homeBloc.add(HomeGetData(isLoading: false));
  }

  @override
  void dispose() {
    homeBloc.state.getDataResult!.data = InOutModel();
    homeBloc.state.getDataResult!.status = ApiStatus.loading;

    homeBloc.state.checkInResult!.data = InOutModel();
    homeBloc.state.checkInResult!.status = ApiStatus.loading;

    homeBloc.state.checkOutResult!.data = InOutModel();
    homeBloc.state.checkOutResult!.status = ApiStatus.loading;
    easyRefreshController.dispose();
    super.dispose();
  }
}
