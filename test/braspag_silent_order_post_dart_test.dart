import 'package:braspag_silent_order_post_dart/silent_order_post.dart';
import 'package:test/test.dart';

main() {
  //TODO PLACE YOUR MERCHANT ID HERE

  var merchantId = "merchant id";

  var request = SilentOrderPostRequest(
      cardHolder: 'Felipe Toniolo',
      cardNumber: '4111111111111111',
      cardExpirationDate: '01/2030',
      cardSecurityCode: '123');

  var sop = SilentOrderPost(
      merchantId: merchantId, enviroment: SilentOrderPostEnviroment.SANDBOX);

  group("correct merchant id", () {
    test('return silent response', () async {
      sop.binQuery = true;
      sop.verifyCard = true;
      sop.tokenize = true;

      SilentOrderPostResponse response =
          await sop.sendCardData(request: request);

      expect(response, isA<SilentOrderPostResponse>());
    });

    test('return response without binQuery', () async {
      sop.binQuery = false;
      sop.verifyCard = true;
      sop.tokenize = true;

      SilentOrderPostResponse response =
          await sop.sendCardData(request: request);

      expect(response.binQueryReturnCode, isNull);
      expect(response, isA<SilentOrderPostResponse>());
    });

    test('return response without verify', () async {
      sop.binQuery = true;
      sop.verifyCard = false;
      sop.tokenize = true;

      SilentOrderPostResponse response =
          await sop.sendCardData(request: request);

      expect(response.verifyCardReturnMessage, isNull);
      expect(response, isA<SilentOrderPostResponse>());
    });

    test('return response with paymentToken and without cardToken', () async {
      sop.binQuery = true;
      sop.verifyCard = true;
      sop.tokenize = false;

      SilentOrderPostResponse response =
          await sop.sendCardData(request: request);

      expect(response.cardToken, isNull);
      expect(response.paymentToken, isNotNull);
    });
  });

  group("incorrect merchant id", () {
    test('return silent response', () async {
      try {
        var sopIncorrectMerchant = SilentOrderPost(
            merchantId: "", enviroment: SilentOrderPostEnviroment.SANDBOX);
        sopIncorrectMerchant.binQuery = true;
        sopIncorrectMerchant.verifyCard = true;
        sopIncorrectMerchant.tokenize = true;

        await sopIncorrectMerchant.sendCardData(request: request);
      } catch (e) {
        expect(e, isA<ErrorResponse>());
      }
    });
  });
}
