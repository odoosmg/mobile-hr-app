import 'package:hrm_employee/Helper/k_enum.dart';

class ApiResult<T> {
  /// Response Status
  ApiStatus? status;
  int? statuscode;
  String? errorMessage;
  bool isSuccess; // true = success , false =failed
  T? data;

  ApiResult({
    this.status,
    this.statuscode,
    this.errorMessage,
    this.isSuccess = false,
    this.data,
  });

  ApiResult<T> copyWith(ApiResult<T> t) {
    ApiResult<T> d = ApiResult<T>();
    d.data = t.data;
    return d;
  }
}
