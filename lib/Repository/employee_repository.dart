import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Models/employee/employee_model.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class EmployeeRepository extends BaseApi {
  Future<ApiResult<EmployeeModel>> list() async {
    Map<String, dynamic> map = await request(
        uri: Endpoint.employeeList,
        params: {
          "company_ids": AppServices.instance<DatabaseService>().getCompanyIds
        });

    map["list"] = map["data"] ?? [];
    map.remove("data");

    return apiResponse(
        status: ApiStatusModel.fromJson(map),
        data: EmployeeModel.fromJson(map));
  }

  Future<ApiResult<UserModel>> detail(int id) async {
    Map<String, dynamic> map = await request(
      uri: Endpoint.employeeDetail,
      params: {
        "employee_id": id,
      },
    );

    return apiResponse(
        status: ApiStatusModel.fromJson(map),
        data: UserModel.fromJson(map["data"] ?? {}));
  }
}
