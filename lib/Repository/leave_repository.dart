import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Models/leave/leave_params.dart';
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
  Future<ApiResult> requestLeave(LeaveModel params) async {
    Map<String, dynamic> map = await request(
      uri: Endpoint.leaveRequest,
      params: LeaveParams.requestLeave(params),
    );

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      // data: LeaveModel.fromJson(map),
    );
  }

  ///
  Future<ApiResult<LeaveModel>> myList() async {
    Map<String, dynamic> map = await request(uri: Endpoint.leaveMyList);

    /// update key
    // map['leave_type_list'] = map["data"] ?? [];
    // map.remove('data');

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: LeaveModel.fromJson(map),
    );
  }
}
