// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_to_approve_list_screen.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_apply.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_my_attendance_list.dart';
import '../../constant.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> myTabs = [
    const Tab(text: 'My List'),
    const Tab(text: 'To Approve List'),
  ];
  late TabController _tabController;

  late LeaveBloc leaveBloc;

  late bool isApprover = false;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    leaveBloc = context.read<LeaveBloc>();

    isApprover = AppServices.instance<DatabaseService>()
        .getPermissoin!
        .leave!
        .isApprover!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bodyPadding: EdgeInsets.zero,
      appBar: CustomAppBar.titleCompany(
          title: "Leave List",
          onChanged: (v, _) {
            leaveBloc.add(LeaveToApproveList(isLoading: true));
          }),
      body: Column(
        children: [
          /// display my_list and approve_list
          if (isApprover) ...[
            ..._hasApprover(),
          ] else ...[
            const Expanded(child: LeaveAttendanceMyList()),
          ]
        ],
      ),
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

  List<Widget> _hasApprover() {
    return [
      /// header
      TabBar.secondary(
        controller: _tabController,
        onTap: (index) {},
        tabs: const <Widget>[
          Tab(text: 'Approve List'),
          Tab(text: 'My List'),
        ],
      ),

      /// body
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: const [
            LeaveToApproveListScreen(),
            LeaveAttendanceMyList(),
          ],
        ),
      ),
    ];
  }

  @override
  void dispose() {
    leaveBloc.add(LeaveListScreenDispose());
    super.dispose();
  }
}
