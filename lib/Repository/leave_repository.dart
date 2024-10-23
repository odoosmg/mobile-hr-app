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
    Map<String, dynamic> map = await request(
      uri: Endpoint.leaveAction,
    );

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
    map.remove('data');

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: LeaveModel.fromJson(map),
    );
  }
}
