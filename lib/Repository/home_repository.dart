import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class HomeRepository extends BaseApi {
  ///
  Future<ApiResult<InOutModel>> checkin() async {
    Map<String, dynamic> map = await request(
      uri: Endpoint.checkIn,
    );

    return apiResponse(
        status: ApiStatusModel.fromJson(map),
        data: InOutModel.fromJson(map["data"] ?? {}));
  }

  Future<ApiResult<InOutModel>> checkout(int id) async {
    Map<String, dynamic> map = await request(
      uri: Endpoint.checkOut,
      params: {"check_in_id": id},
    );

    return apiResponse(
        status: ApiStatusModel.fromJson(map),
        data: InOutModel.fromJson(map["data"] ?? {}));
  }

  Future<ApiResult<InOutModel>> getInOutData() async {
    Map<String, dynamic> map = await request(uri: Endpoint.leaveSummary);

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: InOutModel.fromJson(map["data"] ?? {}),
    );
  }
}
