import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
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

  Future<ApiResult<UserModel>> myPf() async {
    Map<String, dynamic> map = await request(uri: Endpoint.myPf);
    if (map["data"] != null) {
      /// remove key
      map["data"]["company_str"] = map["data"]["company"];
      map["data"].remove("company");
    }
    return apiResponse(
        status: ApiStatusModel.fromJson(map),
        data: UserModel.fromJson(map["data"] ?? {}));
  }
}
