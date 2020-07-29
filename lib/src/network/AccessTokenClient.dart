import 'package:braspag_silent_order_post_dart/silent_order_post.dart';
import 'package:braspag_silent_order_post_dart/src/models/AccessTokenResponse.dart';
import 'package:dio/dio.dart';

class AccessTokenClient {
  Future<AccessTokenResponse> getToken(
      {String merchantId, String baseUrl}) async {
    Dio dio = Dio();

    try {
      dio.options
        ..baseUrl = baseUrl
        ..headers["content-type"] = "application/json";

      var response = await dio.post("v1/accesstoken?merchantid=$merchantId");

      return AccessTokenResponse.fromJson(response.data);
    } on DioError catch (e) {
      _getErrorAccessToken(e);
    }
    return null;
  }
}

_getErrorAccessToken(DioError e) {
  if (e.response != null) {
    var message = e.response.statusCode != null
        ? "${e.response.statusCode} ${e.response.statusMessage}"
        : "Unknown Error";
    throw ErrorResponse(message, e.response.statusMessage);
  } else {
    throw ErrorResponse(e.message, "null");
  }
}
