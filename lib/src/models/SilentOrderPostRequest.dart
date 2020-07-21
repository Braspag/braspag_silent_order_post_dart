class SilentOrderPostRequest {
  String cardHolder;
  String cardNumber;
  String cardExpirationDate;
  String cardSecurityCode;

  SilentOrderPostRequest(
      {this.cardHolder,
      this.cardNumber,
      this.cardExpirationDate,
      this.cardSecurityCode});

  SilentOrderPostRequest.fromJson(Map<String, dynamic> json) {
    cardHolder = json['HolderName'];
    cardNumber = json['RawNumber'];
    cardExpirationDate = json['Expiration'];
    cardSecurityCode = json['SecurityCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HolderName'] = this.cardHolder;
    data['RawNumber'] = this.cardNumber;
    data['Expiration'] = this.cardExpirationDate;
    data['SecurityCode'] = this.cardSecurityCode;
    return data;
  }
}
