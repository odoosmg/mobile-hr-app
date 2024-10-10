// ignore_for_file: depend_on_referenced_packages

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_apply.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_easy_refresh.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/Screens/components/others/xborder.dart';
import 'package:hrm_employee/Screens/components/pages/leave/my_leave_card.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';

import '../../constant.dart';

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaveApplicationState createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  late LeaveBloc leaveBloc;

  final EasyRefreshController easyRefreshController =
      EasyRefreshController(controlFinishRefresh: true);

  bool isOnRefresh = false;

  @override
  void initState() {
    leaveBloc = context.read<LeaveBloc>();
    leaveBloc.add(LeaveMyList(isLoading: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleActions(title: "Leave List", actions: []),
      body: _blocBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => const LeaveApply().launch(context),
        backgroundColor: kMainColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => const LeaveApply().launch(context),
        backgroundColor: kMainColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Leave List',
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Image(
            image: AssetImage('images/employeesearch.png'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () {
                        // const DailyWorkReport().launch(context);
                      },
                      child: Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF7D6AEF),
                              width: 3.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Annual Leave',
                              maxLines: 2,
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'From 16, May 2021 to 20, May 2021',
                              style: kTextStyle.copyWith(
                                color: kGreyTextColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '(Apply Date) 15, May 2021',
                                  style: kTextStyle.copyWith(
                                    color: kGreyTextColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Approved',
                                  style: kTextStyle.copyWith(
                                    color: kGreenColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                const CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: kGreenColor,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () {
                        // const DailyWorkReport().launch(context);
                      },
                      child: Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: kAlertColor,
                              width: 3.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exam Leave',
                              maxLines: 2,
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'From 16, May 2021 to 20, May 2021',
                              style: kTextStyle.copyWith(
                                color: kGreyTextColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '(Apply Date) 15, May 2021',
                                  style: kTextStyle.copyWith(
                                    color: kGreyTextColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Pending',
                                  style: kTextStyle.copyWith(
                                    color: kAlertColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                const CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: kAlertColor,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kbuilder() {
    return KBuilder(
        status: leaveBloc.state.myLeaveListResult!.status!,
        onRetry: () {
          leaveBloc.add(LeaveMyList(isLoading: true));
        },
        builder: (st) {
          return st == ApiStatus.loading ? Container() : _easyRefresh();
        });
  }

  Widget _easyRefresh() {
    return CustomEasyRefresh(
      controller: easyRefreshController,
      onRefresh: () {
        isOnRefresh = true;
        leaveBloc.add(LeaveMyList(isLoading: false));
      },
      child: _display(),
    );
  }

  BlocBuilder _blocBuilder() {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) {
        if (current.stateType == LeaveStateType.myLeaveList) {
          /// on Refresh
          if (isOnRefresh) {
            isOnRefresh = false;
            return false;
          } else {
            /// after onRefresh
            if (current.myLeaveListResult!.isSuccess) {
              easyRefreshController.finishRefresh(IndicatorResult.success);
            } else {
              easyRefreshController.finishRefresh(IndicatorResult.fail);
            }
          }

          return true;
        }
        return false;
      },
      builder: (context, state) {
        return _kbuilder();
      },
    );
  }

  Widget _display() {
    List<LeaveModel> d = leaveBloc.state.myLeaveListResult!.data!.list!;
    return SingleChildScrollView(
      child: SizedBox(
        height: Measurement.heightPercent(context, 0.88),
        child: Column(
          children: [
            16.height,
            _count(),
            16.height,
            const Xborder(),

            /// Empty
            if (d.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: Measurement.screenPadding),
                child: Text(
                  "You don't have any request leave yet.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.greyS13W400,
                ),
              ),

            ///
            for (int i = 0; i < d.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: Measurement.screenPadding),
                child: MyLeaveCard(data: d[i]),
              )
          ],
        ),
      ),
    );
  }

  Widget _count() {
    List<LeaveModel> d =
        leaveBloc.state.myLeaveListResult?.data?.leaveAllocatedSummary ?? [];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < d.length; i++)
          Text("${d[i].name} : ${d[i].allocate}",
              style: Theme.of(context).textTheme.blackS12W400),
      ],
    );
  }

  @override
  void dispose() {
    easyRefreshController.dispose();
    super.dispose();
  }
}
