import 'dart:async';
import 'package:attendance_location/api/base_api_service.dart';
import 'package:attendance_location/model/models.dart';
import 'package:dio/dio.dart';

class ApiService extends BaseApiServices {
  @override
  Future post(String url, {Map<String, String>? headers, body}) async {
    dynamic responseJson;
    var dio = Dio();
    try {
      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      responseJson = returnReponse(response);
    } on DioError catch (e) {
      return ApiReturnValue(
        value: null,
        message: e.message,
      );
    } catch (e) {
      return ApiReturnValue(
        value: null,
        message: e.toString(),
      );
    }

    return responseJson;
  }
}

ApiReturnValue returnReponse(Response response) {
  if ((response.statusCode ?? 0) < 200 && (response.statusCode ?? 0) >= 300) {
    return ApiReturnValue(
      value: null,
      message: response.statusMessage,
    );
  }
  return ApiReturnValue(value: response.data);
}
