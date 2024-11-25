import 'package:hrm_employee/Models/leave/leave_model.dart';

class LeaveParams {
  static Map<String, dynamic> requestLeave(LeaveModel params) {
    Map<String, dynamic> d = {
      "leave_type_id": params.leaveTypeId,
      "date_from": params.dateFrom,
      "date_to": params.dateTo,
      "description": params.description,
      "half_day": params.isHalfDay,
      "request_date_from_period": params.datePeriod,
    };
    return d;
  }

  static Map<String, dynamic> action(int id, String state) =>
      {"leave_id": id, "action_name": state};

  static Map<String, dynamic> page(int page) => {"page": page};
  static Map<String, dynamic> attendanceList(int p, String from, String to) {
    final d = page(p);
    d.addAll({"filter_from_date": from, "filter_to_date": to});
    return d;
  }
}
