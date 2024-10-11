import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class PublicHolidayRepository extends BaseApi {
  ///
  Future<ApiResult<InOutModel>> byYear(String year) async {
    Map<String, dynamic> map = await request(
        uri: Endpoint.publicHolidayByYear, params: {"year": year});

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      // data: InOutModel.fromJson(map["data"] ?? {}),
    );
  }
}
