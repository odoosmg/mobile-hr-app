import 'package:hrm_employee/Models/PublicHoliday/public_holiday_model.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class PublicHolidayRepository extends BaseApi {
  ///
  Future<ApiResult<PublicHolidayModel>> byYear(int year) async {
    Map<String, dynamic> map = await request(
        uri: Endpoint.publicHolidayByYear, params: {"year": year});

    map["list"] = map["data"] ?? [];
    map.remove("data");

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: PublicHolidayModel.fromJson(map),
    );
  }
}
