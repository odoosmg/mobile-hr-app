import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Models/employee/employee_model.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class EmployeeRepository extends BaseApi {
  Future<ApiResult<EmployeeModel>> list() async {
    Map<String, dynamic> map = await request(uri: Endpoint.employeeList);

    return apiResponse(
        status: ApiStatusModel.fromJson(map),
        data: EmployeeModel.fromJson(map["data"] ?? {}));
  }
}
