// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/TableCalendarDialog/ui/table_calendar_dialog.dart';
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
import 'package:table_calendar/table_calendar.dart';
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
    // return CustomScaffold(body: TableCalendarDialog());

    return CustomScaffold(
      bodyPadding: EdgeInsets.zero,
      appBar: CustomAppBar.titleCompany(
          title: "Leave List",
          onChanged: (v, _) {
            leaveBloc.add(LeaveToApproveList(isLoading: true));
          }),
      body: Column(
        children: [
          /// Test Modal
          // ElevatedButton(
          //   onPressed: () {
          //     _showCalendarDialog();
          //   },
          //   child: Text("click"),
          // ),

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

  void _showCalendarDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select a Date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: DateTime.now(),
                  headerStyle: const HeaderStyle(
                    formatButtonShowsNext: false,
                    formatButtonVisible: false,
                  ),
                  // selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    // Navigator.of(context)
                    //     .pop(); // Close dialog on date selection
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Close"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // leaveBloc.add(LeaveListScreenDispose());
    super.dispose();
  }
}
