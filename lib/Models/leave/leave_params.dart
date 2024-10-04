import 'package:hrm_employee/Models/leave/leave_model.dart';

class LeaveParams {
  static Map<String, dynamic> requestLeave(LeaveModel params) {
    Map<String, dynamic> d = {
      "leave_type_id": params.leaveTypeId,
      "date_from": params.dateForm,
      "date_to": params.dateTo,
      "description": params.description,
      "half_day": params.isHalfDay,
      "request_date_from_period": params.datePeriod,
      // "number_of_days": "0"
    };
    return d;
  }
}
