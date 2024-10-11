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

    return SizedBox(
      height: Measurement.heightPercent(context, 0.88),
      child: SingleChildScrollView(
        child: Column(
          children: [
            8.height,
            _count(),
            8.height,
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

    return Container(
      alignment: Alignment.center,
      height: 30 * _caculateTotalRow(d.length).toDouble(),
      width: double.infinity,
      child: GridView.count(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 5, // space item
        children: [
          for (int i = 0; i < d.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text("${d[i].name} : ${d[i].remaining}",
                  style: Theme.of(context).textTheme.blackS12W400),
            ),
        ],
      ),
    );
  }

  int _caculateTotalRow(int records) {
    int v = records ~/ 3;

    if (v == 0) {
      return 1;
    }

    if (records % 3 > 0) {
      v += 1;
    }
    return v;
  }

  @override
  void dispose() {
    easyRefreshController.dispose();
    super.dispose();
  }
}
