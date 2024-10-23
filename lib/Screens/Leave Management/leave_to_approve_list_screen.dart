// ignore_for_file: depend_on_referenced_packages

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_easy_refresh.dart';
import 'package:hrm_employee/Screens/components/pages/leave/my_leave_card.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class LeaveToApproveListScreen extends StatefulWidget {
  const LeaveToApproveListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaveToApproveListScreenState createState() =>
      _LeaveToApproveListScreenState();
}

class _LeaveToApproveListScreenState extends State<LeaveToApproveListScreen>
    with AutomaticKeepAliveClientMixin {
  late LeaveBloc leaveBloc;

  final EasyRefreshController easyRefreshController =
      EasyRefreshController(controlFinishRefresh: true);

  bool isOnRefresh = false;

  @override
  void initState() {
    leaveBloc = context.read<LeaveBloc>();
    leaveBloc.add(LeaveToApproveList(isLoading: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(
        right: Measurement.screenPadding,
        left: Measurement.screenPadding,
      ),
      child: _blocBuilder(),
    );
  }

  Widget _kbuilder() {
    return KBuilder(
        status: leaveBloc.state.toApproveListResult!.status!,
        onRetry: () {
          leaveBloc.add(LeaveToApproveList(isLoading: true));
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
        leaveBloc.add(LeaveToApproveList(isLoading: false));
      },
      child: _display(),
    );
  }

  BlocBuilder _blocBuilder() {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) {
        if (current.stateType == LeaveStateType.toApproveList) {
          /// on Refresh
          if (isOnRefresh) {
            isOnRefresh = false;
            return false;
          } else {
            /// after onRefresh
            if (current.toApproveListResult!.isSuccess) {
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
    List<LeaveModel> d =
        leaveBloc.state.toApproveListResult!.data!.toApprovedList!;

    return SizedBox(
      height: Measurement.heightPercent(context, 0.88),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Empty
            if (d.isEmpty)
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: Measurement.screenPadding),
                  child: Text(
                    AppTrans.t.emptyContent,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.greyS13W400,
                  ),
                ),
              ),

            ///
            for (int i = 0; i < d.length; i++)
              Padding(
                padding: const EdgeInsets.only(
                  top: Measurement.screenPadding,
                ),
                child: MyLeaveCard(data: d[i], isToApproved: true),
              )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    easyRefreshController.dispose();
    super.dispose();
  }

  /// fixed refresh from TabBarView
  @override
  bool get wantKeepAlive => true;
}
