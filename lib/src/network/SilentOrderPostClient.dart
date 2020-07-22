import 'package:braspag_silent_order_post_dart/silent_order_post.dart';
import 'package:braspag_silent_order_post_dart/src/models/SilentOrderPostError.dart';
import 'package:braspag_silent_order_post_dart/src/models/SilentOrderPostRequest.dart';
import 'package:braspag_silent_order_post_dart/src/models/SilentOrderPostResponse.dart';
import 'package:braspag_silent_order_post_dart/src/network/AccessTokenClient.dart';
import 'package:dio/dio.dart';

class SilentOrderPostClient {
  Future<SilentOrderPostResponse> sendTransaction(
      {SilentOrderPostRequest request,
      String merchantId,
      bool binQuery,
      bool verifyCard,
      bool tokenize,
      String baseUrl}) async {
    try {
      Dio dio = Dio();

      AccessTokenClient tokenClient = AccessTokenClient();

      var accessTokenResponse =
          await tokenClient.getToken(merchantId: merchantId, baseUrl: baseUrl);

      Map<String, String> body = {
        'HolderName': request.cardHolder,
        'RawNumber': request.cardNumber,
        'Expiration': request.cardExpirationDate,
        'SecurityCode': request.cardSecurityCode,
        'EnableBinQuery': binQuery.toString(),
        'EnableVerifyCard': verifyCard.toString(),
        'EnableTokenize': tokenize.toString(),
        'AccessToken': accessTokenResponse.accessToken
      };

      dio.options
        ..baseUrl = baseUrl
        ..headers["content-type"] = "application/x-www-form-urlencoded";

      var response = await dio.post("v1/card", data: body);

      return SilentOrderPostResponse.fromJson(response.data);
    } on DioError catch (e) {
      _getErrorSilentOrderPost(e);
    }
    return null;
  }
}

_getErrorSilentOrderPost(DioError e) {
  if (e.response != null) {
    if (e.response.data != "") {
      Map<String, dynamic> map = e.response.data;
      SilentOrderPostError silentOrderPostError =
          SilentOrderPostError.fromJson(map);
      var message = e.response.statusCode != null
          ? "${e.response.statusCode} ${e.response.statusMessage}"
          : "Unknown Error";

      throw ErrorResponse(message, silentOrderPostError.modelState.request);
    } else {
      var silentOrderPostError = SilentOrderPostError(
          message: "", modelState: ModelState(request: ""));
      var message = e.response.statusCode != null
          ? "${e.response.statusCode} ${e.response.statusMessage}"
          : "Unknown Error";

      throw ErrorResponse(message, "null");
    }
  } else {
    throw ErrorResponse("Unknown Error", "Unknown Error");
  }
}
