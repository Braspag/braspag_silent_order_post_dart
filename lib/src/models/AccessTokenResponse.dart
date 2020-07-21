class AccessTokenResponse {
  String merchantId;
  String accessToken;
  String issued;
  String expiresIn;

  AccessTokenResponse(
      {this.merchantId, this.accessToken, this.issued, this.expiresIn});

  AccessTokenResponse.fromJson(Map<String, dynamic> json) {
    merchantId = json['MerchantId'];
    accessToken = json['AccessToken'];
    issued = json['Issued'];
    expiresIn = json['ExpiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MerchantId'] = this.merchantId;
    data['AccessToken'] = this.accessToken;
    data['Issued'] = this.issued;
    data['ExpiresIn'] = this.expiresIn;
    return data;
  }
}
