import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/api/base_api.dart';
import 'package:hrm_employee/api/endpoint.dart';

class FormDataRepository extends BaseApi {
  ///
  Future<ApiResult<List<SelectFormModel>>> companyList() async {
    Map<String, dynamic> map = await request(uri: Endpoint.companyList);

    /// add new key
    if (map["data"] != null) {
      map["data"].map((e) {
        e['is_selected'] = false;
      }).toList();
    }
/*
    map["data"] = [
      {
        "id": 1,
        "name": "Company A",
        "is_selected": false,
      },
      {
        "id": 2,
        "name": "Company B",
        "is_selected": false,
      },
      {
        "id": 3,
        "name": "Company C",
        "is_selected": false,
      },
      {
        "id": 4,
        "name": "Company D",
        "is_selected": false,
      },
      {
        "id": 5,
        "name": "Company E",
        "is_selected": false,
      }
    ];
*/
    return apiResponse(
      status: ApiStatusModel.fromJson(map),
      data: List.from(
          (map["data"] ?? []).map((e) => SelectFormModel.fromJson(e)).toList()),
    );
  }
}
