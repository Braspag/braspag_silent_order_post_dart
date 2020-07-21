import 'package:braspag_silent_order_post_dart/braspag_silent_order_post_dart.dart';
import 'package:braspag_silent_order_post_dart/src/models/SilentOrderPostRequest.dart';
import 'package:braspag_silent_order_post_dart/src/models/SilentOrderPostResponse.dart';
import 'package:braspag_silent_order_post_dart/src/network/SilentOrderPostClient.dart';

class SilentOrderPost {
  String merchantId;
  SilentOrderPostEnviroment enviroment;

  SilentOrderPost(
      {this.merchantId, this.enviroment = SilentOrderPostEnviroment.SANDBOX});

  var binQuery = false;
  var verifyCard = false;
  var tokenize = false;

  Future<SilentOrderPostResponse> sendCardData(
      {SilentOrderPostRequest request}) async {
    var baseUrl = _baseUrl(enviroment);

    SilentOrderPostClient silentOrderPostClient = SilentOrderPostClient();

    return await silentOrderPostClient.sendTransaction(
        request: request,
        merchantId: merchantId,
        binQuery: binQuery,
        verifyCard: verifyCard,
        tokenize: tokenize,
        baseUrl: baseUrl);
  }
}

String _baseUrl(SilentOrderPostEnviroment enviroment) {
  return enviroment == SilentOrderPostEnviroment.PRODUCAO
      ? "https://transaction.pagador.com.br/post/api/public/"
      : "https://transactionsandbox.pagador.com.br/post/api/public/";
}
