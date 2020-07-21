class SilentOrderPostError {
  String message;
  ModelState modelState;

  SilentOrderPostError({this.message, this.modelState});

  factory SilentOrderPostError.fromJson(Map<String, dynamic> json) {
    return SilentOrderPostError(
      message: json['Message'] as String,
      modelState: json['ModelState'] as Map<String, dynamic> != null
          ? ModelState.fromJson(json['ModelState'])
          : null,
    );
  }
}

class ModelState {
  String request;

  ModelState({this.request});

  ModelState.fromJson(Map<String, dynamic> json) {
    if (json['request.HolderName'] != null) {
      request = json['request.HolderName'].cast<String>()[0];
    } else if (json['request.RawNumber'] != null) {
      request = json['request.RawNumber'].cast<String>()[0];
    } else if (json['request.Expiration'] != null) {
      request = json['request.Expiration'].cast<String>()[0];
    } else {
      request = "";
    }
  }
}
