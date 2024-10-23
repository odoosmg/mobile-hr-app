import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Models/leave/leave_params.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class LeaveRepository extends BaseApi {
  Future<ApiResult<LeaveModel>> leavTypeList() async {
    Map<String, dynamic> map = await request(uri: Endpoint.leaveTypeList);

    /// update key
    map['leave_type_list'] = map["data"] ?? [];
    map.remove('data');

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: LeaveModel.fromJson(map),
    );
  }

  ///
  Future<ApiResult<LeaveModel>> requestLeave(LeaveModel params) async {
    Map<String, dynamic> map = await request(
      uri: Endpoint.leaveRequest,
      params: LeaveParams.requestLeave(params),
    );

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: LeaveModel.fromJson(map['data'] ?? {}),
    );
  }

  ///
  Future<ApiResult<LeaveModel>> myList() async {
    Map<String, dynamic> map = await request(uri: Endpoint.leaveMyList);

    /// update key to 1 level
    map['list'] = map["data"]?["leave_requested"] ?? [];
    map['leave_allocated_summary'] =
        map["data"]?["leave_allocated_summary"] ?? [];
    map.remove('data');

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: LeaveModel.fromJson(map),
    );
  }

  /// Approved or Refuse
  Future<ApiResult<LeaveModel>> leaveAction(int id, String state) async {
    Map<String, dynamic> map =
        await request(uri: Endpoint.leaveAction, params: {});
    map = {"status_code": 200};
    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: LeaveModel.fromJson(map['data'] ?? {}),
    );
  }

  ///
  Future<ApiResult<LeaveModel>> toApproveList() async {
    Map<String, dynamic> map =
        await request(uri: Endpoint.leaveToApproveList, params: {
      "company_ids": AppServices.instance<DatabaseService>().getCompanyIds ?? []
    });

    /// update key to 1 level
    map['list'] = map["data"]?["to_approve"] ?? [];
    map['to_approved_list'] = map["data"]?["to_approve"] ?? [];
    /*
    map['to_approved_list'] = [
      {
        "id": 148,
        "date_from": "2024-10-19",
        "date_to": "2024-10-19",
        "employee_id": 4,
        "employee_name": "tester_1",
        "number_of_days": 1.0,
        "leave_type_id": 4,
        "leave_type_name": "Unpaid",
        "state": "To Approve",
        "request_unit_half": false,
        "request_date_from_period": ""
      },
      {
        "id": 2,
        "date_from": "2024-09-28",
        "date_to": "2024-09-28",
        "employee_id": 10,
        "employee_name": "Rainy Vay",
        "number_of_days": 0.0,
        "leave_type_id": 2,
        "leave_type_name": "Sick Time Off",
        "state": "To Approve",
        "request_unit_half": false,
        "request_date_from_period": ""
      },
    ];
    */
    map.remove('data');

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: LeaveModel.fromJson(map),
    );
  }
}
