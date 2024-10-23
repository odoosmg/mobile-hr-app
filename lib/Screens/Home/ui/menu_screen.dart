// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
// ignore: depend_on_referenced_packages
import 'package:nb_utils/nb_utils.dart';

import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_screen.dart';
import 'package:hrm_employee/Screens/PublicHoliday/public_holiday_screen.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/constant.dart';
import 'package:hrm_employee/Screens/Home/bloc/home_bloc.dart';
import 'package:hrm_employee/Screens/Employee%20Directory/employee_directory_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();

    /// get data
    homeBloc.add(HomeAppPermission());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleActions(title: "Apps"),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          /// Alert message when failed
          if (state.stateType == HomeStateType.appPermission) {
            if (state.permissionResult!.status != ApiStatus.loading &&
                !state.permissionResult!.isSuccess) {
              _permissionFailedSnackbar();
            }
          }
        },
        buildWhen: (previous, current) {
          return current.stateType == HomeStateType.appPermission;
        },
        builder: (context, state) {
          return _kbuilder();
        },
      ),
    );
  }

  Widget _kbuilder() {
    return KBuilder(
      status: homeBloc.state.permissionResult!.status!,
      failed: Column(
        children: _gridMenu(context),
      ),
      builder: (st) {
        return st == ApiStatus.loading
            ? Container()
            : Column(
                children: _gridMenu(context),
              );
      },
    );
  }

  Widget _display(ApiStatus st) {
    return st == ApiStatus.loading
        ? Container()
        : Column(
            children: _gridMenu(context),
          );
  }

  List<Widget> _gridMenu(BuildContext context) {
    return [
      20.height,
      Row(
        children: [
          _material(
            context: context,
            image: const SizedBox(
              height: 68,
              child: Image(
                image: AssetImage('images/calendar.png'),
                height: 100,
              ),
            ),
            borderColor: const Color.fromARGB(225, 226, 191, 116),
            text1: "Public",
            text2: "Holiday",
            onTap: () {
              const PublicHolidayScreen().launch(context);
            },
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
      if (AppServices.instance<DatabaseService>().isGetPermissionSucces)
        Row(
          children: [
            Expanded(
              child: Material(
                elevation: 2.0,
                child: GestureDetector(
                  onTap: () {
                    // const LeaveApplication().launch(context);
                    const LeaveScreen().launch(context);
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
            _emptyCard(context),
            /*
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
          */
          ],
        ),

      /*
      20.height,
      Row(
        children: [
          _material(
              context: context,
              image: const Image(
                image: AssetImage('images/calendar.png'),
                height: 70,
              ),
              borderColor: const Color.fromARGB(225, 226, 191, 116),
              text1: "Public",
              text2: "Holiday",
              onTap: () {
                const PublicHolidayScreen().launch(context);
              }),
          20.width,

          /// Empty for space
          Container(
            child: _material(
              context: context,
              image: Container(),
              borderColor: white,
              text1: "",
              text2: "",
              elevation: 0,
            ),
          ),
        ],
      ),
      */
    ];
  }

  Widget _material({
    required BuildContext context,
    required Widget image,
    required String text1,
    required String text2,
    required Color borderColor,
    double elevation = 2.0,
    Function()? onTap,
  }) {
    return Expanded(
      child: Material(
        elevation: elevation,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: context.width(),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: borderColor,
                  width: 3.0,
                ),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image,
                Text(
                  text1,
                  style: kTextStyle.copyWith(
                      color: kTitleColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  text2,
                  style: kTextStyle.copyWith(
                      color: kTitleColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _emptyCard(BuildContext context) {
    return Container(
      child: _material(
        context: context,
        image: Container(),
        borderColor: white,
        text1: "",
        text2: "",
        elevation: 0,
      ),
    );
  }

  void _permissionFailedSnackbar() {
    Flushbar(
      // isDismissible: false,
      backgroundColor: AppColor.kDangerColor,
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
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      titleText: const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 24,
      ),
      messageText: Text(
        "Get Permission failed!",
        style: Theme.of(context).textTheme.whiteS13W500.copyWith(fontSize: 17),
        textAlign: TextAlign.center,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
    ).show(context);
  }
}
