import 'package:braspag_silent_order_post_dart/src/models/SilentOrderPostError.dart';

class SilentOrderPostException implements Exception {
  final String statusCode;
  final SilentOrderPostError silentOrderPostError;

  SilentOrderPostException(this.statusCode, this.silentOrderPostError);
}
