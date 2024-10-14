import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class FormDataRepository extends BaseApi {
  ///
  Future<ApiResult<List<SelectFormModel>>> companyList() async {
    Map<String, dynamic> map = await request(uri: Endpoint.companyList);

    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: List.from(
          (map["data"] ?? []).map((e) => SelectFormModel.fromJson(e)).toList()),
    );
  }
}
