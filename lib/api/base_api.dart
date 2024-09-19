import 'package:dio/dio.dart'
    show Dio, DioException, Options, BaseOptions, DioExceptionType;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/api/config_api.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Helper/logger_custom.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';

class BaseApi extends ResponseT {
  final Map<String, dynamic> _headers = {
    'Content-Type': 'multipart/form-data',
  };

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ConfigApi.baseApi,
    ),
  );

  /// return back as Map
  Future<Map<String, dynamic>> request({
    required String uri,
    Map<String, dynamic>? params,
    Object? data,
    Method method = Method.post,
  }) async {
    Map<String, dynamic> data = {};

    /// added Auth key
    if (AppServices.instance<DatabaseService>().getToken.isNotEmpty) {
      _headers['Authorization'] =
          'Bearer ${AppServices.instance<DatabaseService>().getToken}';
      _headers['Refresh-Token'] =
          AppServices.instance<DatabaseService>().getRefreshToken;
    } else {
      _headers.remove('Authorization');
      _headers.remove('Refresh-Token');
    }

    try {
      try {
        final response = await _dio.request(
          uri,
          options: Options(
            method: method.name,
            headers: _headers,
          ),
          data: data,
          queryParameters: params ?? {},
        );
        data = response.data;
      } on DioException catch (e) {
        /// BAD REQUEST
        data = _dioExceptionRespnose(e);
      }

      /// Logger
      LoggerCustom.apiLogger(
        statusCode: data["status_code"],
        url: _dio.options.baseUrl + uri,
        response: data,
        params: params ?? {},
        headers: _headers,
        method: method,
      );

      /// final return
      return data;
    } catch (ex) {
      debugPrint("Exception : $ex");
      return {"error_message": "AppTrans.t.unexpectedErr", "status_code": 500};
    }
  }

  Map<String, dynamic> _dioExceptionRespnose(DioException e) {
    Map<String, dynamic> data = {};
    int? statusCode;

    /// response = null, happens when no internent
    if (e.response != null) {
      /// prevent Sring response.
      /// like 405, response is String.
      if (e.response!.data.runtimeType != String) {
        data = e.response!.data as Map<String, dynamic>;
      }

      statusCode = e.response?.statusCode;

      data["status_code"] = statusCode;

      ///
      checkExpired(statusCode ?? 400);

      switch (statusCode) {
        case 404:
          data["error_message"] = "Not Found.";
          break;
        case 405:
          data["error_message"] = "Method not allowed.";
          break;
        case 503:
          data["error_message"] = "AppTrans.t.connectionErrMsg";
          break;
        default:
          if ((data["error"]["fields"] ?? []).length > 0) {
            /// fields error
            data["error_message"] = "please double check on field";
          } else {
            data["error_message"] = data["error"]["error_message"];
          }
      }
    }

    ///
    if (e.type == DioExceptionType.connectionError) {
      data["status_code"] = ApiStatus.connectionError.statusCode;
      data["error_message"] = "AppTrans.t.connectionErrMsg";
    }

    return data;
  }

  /// Testing with formdata
  /// this is sepcial case.
  /// somehow it works these conditions,  contentType:application/json, parameters is formData
  Future<Map<String, dynamic>> postFormData({
    required String uri,
    Object? data,
  }) async {
    Map<String, dynamic> resData = {};
    try {
      try {
        await _dio
            .post("${ConfigApi.baseApi}$uri",
                data: data,
                options: Options(headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization':
                      'Bearer ${"AppServices.instance<DatabaseService>().getToken"}'
                }))
            .then((response) {
          resData = response.data;

          ///
          resData['status_code'] = response.statusCode;

          /// remove status. error types
          resData.remove("status");
        });
      } on DioException catch (e) {
        resData = _dioExceptionRespnose(e);

        resData.remove("status");
      }

      LoggerCustom.apiLogger(
          method: Method.post,
          url: _dio.options.baseUrl + uri,
          params: data,
          statusCode: resData["status_code"],
          response: resData);
      return resData;
    } catch (ex) {
      debugPrint("Exception : $ex");
      return {"error_message": "AppTrans.t.unexpectedErr", "status_code": 500};
    }
  }

  void checkExpired(int statusCode) {
    /// Expired
    /// 401 and have token
    if (statusCode == 401 &&
        AppServices.instance<DatabaseService>().getToken.isNotEmpty) {
      AppServices.instance<DatabaseService>().clearSession();
      // Get.offAllNamed(LoginPage.route);
      // CustomDialog.error(statusCode, AppTrans.t.tokenExpiredMsg);

      return;
    }
  }

  void updateHeaders() {
    /// added Auth key
    // if (AppServices.instance<DatabaseService>().getToken.isNotEmpty) {
    //   _headers['Authorization'] =
    //       'Bearer ${AppServices.instance<DatabaseService>().getToken}';
    // }
  }
}

/// ResponseT this name for not the same as Response in dio
abstract class ResponseT {
  /// repsonse with status
  ApiResult<T> apiResponse<T>({
    required ApiStatusModel status,
    T? data,
    ApiStatus state = ApiStatus.loading,
  }) {
    /// return status by status code
    switch (status.statusCode) {
      case 200:
        state = ApiStatus.success;
        break;

      case 401:
        state = ApiStatus.unAuthorize;
        break;
      // case 4003:
      //   state = ApiStatus.loginExpired;

      case 503:
        state = ApiStatus.connectionError;
        break;
      default:
        state = ApiStatus.failed;
    }

    // if (state == ApiStatus.loginExpired) {
    // AppServices.instance<DatabaseService>().clearLocalUser();
    //   Get.offAllNamed(LoginPage.route);
    //   return ApiResult();
    // }

    /// Response to client
    return ApiResult(
      status: state, // custom code
      data: data,
      statuscode: status.statusCode,
      errorMessage: status.errorMessage ?? '',
      isSuccess: state == ApiStatus.success,
    );
  }
}
