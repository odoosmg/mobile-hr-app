import 'package:hrm_employee/Helper/k_enum.dart' show Logger, Method;

class LoggerCustom {
  static void apiLogger({
    int? statusCode,
    String? url,
    dynamic response,
    dynamic params,
    dynamic headers,
    required Method method,
  }) {
    Logger.white.log('_________ [ START REQUEST ] _________');
    Logger.cyan.log('URL [${method.name}] : $url');

    Logger.magenta.log('HEADER : $headers');
    Logger.magenta.log('BODY : $params');

    // Logger.blue.log('STATUS CODE : $statusCode');
    if (statusCode != null && statusCode == 200) {
      Logger.green.log('RESPONSE : $response');
    } else {
      Logger.red.log('RESPONSE : $response');
    }
    Logger.white.log('_________ [ END REQUEST ] _________');
  }
}
