import 'dart:async';

import 'package:braspag_silent_order_post_dart/silent_order_post.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo SilentOrderPost',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SilentOrderPost Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SilentBloc bloc = SilentBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<SilentOrderPostResponse>(
                stream: bloc.output,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Container(
                      child: Text(
                        "Aperte em + para iniciar a pesquisa",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      ),
                    );
                  if (snapshot.hasError) {
                    ErrorResponse errors = snapshot.error;
                    print('Errors =>  StatusCode: ${errors.code}, '
                        'Description: ${errors.message}');
                    return Container();
                  } else
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          snapshot.data.foreignCard != null
                              ? Text(
                                  'ForeignCard => : ${snapshot.data.foreignCard}')
                              : Text(''),
                          snapshot.data.binQueryReturnCode != null
                              ? Text(
                                  'BinQuery Return Code => : ${snapshot.data.binQueryReturnCode}')
                              : Text(''),
                          snapshot.data.brand != null
                              ? Text('Brand => : ${snapshot.data.brand}')
                              : Text(''),
                          snapshot.data.binQueryReturnMessage != null
                              ? Text(
                                  'BinQuery Return Message => : ${snapshot.data.binQueryReturnMessage}')
                              : Text(''),
                          snapshot.data.verifyCardStatus != null
                              ? Text(
                                  'VerifyCard Status => : ${snapshot.data.verifyCardStatus}')
                              : Text(''),
                          snapshot.data.verifyCardReturnCode != null
                              ? Text(
                                  'VerifyCard Return Code => : ${snapshot.data.verifyCardReturnCode}')
                              : Text(''),
                          snapshot.data.verifyCardReturnMessage != null
                              ? Text(
                                  'VerifyCard Return Message => : ${snapshot.data.verifyCardReturnMessage}')
                              : Text(''),
                          snapshot.data.cardBin != null
                              ? Text('CardBin => : ${snapshot.data.cardBin}')
                              : Text(''),
                          snapshot.data.cardLast4Digits != null
                              ? Text(
                                  'CardLast4Digits => : ${snapshot.data.cardLast4Digits}')
                              : Text(''),
                          snapshot.data.cardToken != null
                              ? Text(
                                  'Card Token => : ${snapshot.data.cardToken}')
                              : Text(''),
                        ],
                      ),
                    );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("iniciando consulta");
          bloc.input.add(sendCard());
        },
        tooltip: 'Consultation Card',
        child: Icon(Icons.search),
      ),
    );
  }

  SilentOrderPostRequest sendCard() {
    return SilentOrderPostRequest(
        cardHolder: 'Felipe Toniolo',
        cardNumber: '4111111111111111',
        cardExpirationDate: '01/2030',
        cardSecurityCode: '123');
  }
}

class SilentBloc {
  StreamController<SilentOrderPostRequest> _streamController =
      StreamController<SilentOrderPostRequest>.broadcast();

  Sink<SilentOrderPostRequest> get input => _streamController.sink;
  Stream<SilentOrderPostResponse> get output =>
      _streamController.stream.asyncMap((card) => sendCard(card));

  Future<SilentOrderPostResponse> sendCard(SilentOrderPostRequest card) async {
    var sop = SilentOrderPost(
        merchantId: "Merchant id",
        enviroment: SilentOrderPostEnviroment.SANDBOX);

    sop.binQuery = true;
    sop.verifyCard = true;
    sop.tokenize = true;

    return await sop.sendCardData(request: card);
  }

  dispose() => _streamController.close();
}
