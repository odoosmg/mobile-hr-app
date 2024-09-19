import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class AuthRepository extends BaseApi {
  Future<ApiResult<Session>> login(String username, String password) async {
    Map<String, dynamic> map = await request(
      uri: Endpoint.login,
      params: {"username": username, "password": password},
    );

    return apiResponse(
        status: ApiStatusModel.fromJson(map),
        data: Session.fromJson(map["data"] ?? {}));
  }

  Future<ApiResult<Session>> myPf() async {
    Map<String, dynamic> map = await request(
      uri: Endpoint.myPf,
      // params: {"username": username, "password": password},
    );

    return apiResponse(
        status: ApiStatusModel.fromJson(map),
        data: Session.fromJson(map["data"] ?? {}));
  }
}
