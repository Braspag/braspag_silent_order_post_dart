class SilentOrderPostResponse {
  bool foreignCard;
  String binQueryReturnCode;
  String binQueryReturnMessage;
  String brand;
  int verifyCardStatus;
  String verifyCardReturnCode;
  String verifyCardReturnMessage;
  String cardBin;
  String cardLast4Digits;
  String cardToken;

  SilentOrderPostResponse(
      {this.foreignCard,
      this.binQueryReturnCode,
      this.binQueryReturnMessage,
      this.brand,
      this.verifyCardStatus,
      this.verifyCardReturnCode,
      this.verifyCardReturnMessage,
      this.cardBin,
      this.cardLast4Digits,
      this.cardToken});

  SilentOrderPostResponse.fromJson(Map<String, dynamic> json) {
    foreignCard = json['ForeignCard'];
    binQueryReturnCode = json['BinQueryReturnCode'];
    binQueryReturnMessage = json['BinQueryReturnMessage'];
    brand = json['Brand'];
    verifyCardStatus = json['VerifyCardStatus'];
    verifyCardReturnCode = json['VerifyCardReturnCode'];
    verifyCardReturnMessage = json['VerifyCardReturnMessage'];
    cardBin = json['CardBin'];
    cardLast4Digits = json['CardLast4Digits'];
    cardToken = json['CardToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ForeignCard'] = this.foreignCard;
    data['BinQueryReturnCode'] = this.binQueryReturnCode;
    data['BinQueryReturnMessage'] = this.binQueryReturnMessage;
    data['Brand'] = this.brand;
    data['VerifyCardStatus'] = this.verifyCardStatus;
    data['VerifyCardReturnCode'] = this.verifyCardReturnCode;
    data['VerifyCardReturnMessage'] = this.verifyCardReturnMessage;
    data['CardBin'] = this.cardBin;
    data['CardLast4Digits'] = this.cardLast4Digits;
    data['CardToken'] = this.cardToken;
    return data;
  }
}
