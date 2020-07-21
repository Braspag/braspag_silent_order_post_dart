# Silent Order Post

Integração que a Braspag oferece aos lojistas, onde os dados de pagamentos são trafegados de forma segura, mantendo o controle total sobre a experiência de checkout.

Esse método possibilita o envio dos dados do pagamento do seu cliente de forma segura, diretamente em nosso sistema. Os dados de pagamento, tais como número do cartão e data de validade são armazenados no ambiente da Braspag, que conta com a certificação PCI DSS 3.2.

É ideal para lojistas que exigem um alto grau de segurança, sem perder a identidade do seu app, permitindo total personalização do seu checkout.

## Modo de Uso 

### Instalação
- Será necessário adicionar a seguinte dependência ao **pubspec.yaml** do seu app:

```yaml
    dependencies:
      braspag_silent_order_post_dart: ^1.0.0
```

### Utilização
Para iniciar com o SDK será necessário importar o pacote abaixo.

```dart
import 'package:braspag_silent_order_post_dart/braspag_silent_order_post_dart.dart';
```

Será necessário também informar *Merchant Id* e o *Ambiente*:
- **String merchantId** = Obrigatorio.
- **SilentOrderPostEnviroment enviroment** = Não Obrigatorio, caso não seja informado o SDK ultilizará **SANDBOX**.

Instancie **SilentOrderPost** como exemplo abaixo:

```dart
var sop = SilentOrderPost(
        merchantId: 'MERCHANT-ID',
        enviroment: SilentOrderPostEnviroment.SANDBOX);
```

### Definir parâmetros

Os parâmetros que podem ser configurados são **binQuery**, **confirmCard** e **tokenize**.

| Parâmetros 	| Produtos         	| Resposta                                               	|
|------------	|------------------	|--------------------------------------------------------	|
| binQuery   	| Consulta BIN     	| Card Data                                              	|
| verifyCard 	| Zero Auth        	| Retorna se o cartão é válido                               	|
| tokenize   	| Cartão Protegido 	| CardToken se definido como true, PaymentToken se definido como false 	|


```yaml
sop.binQuery = true;
sop.verifyCard = true;
sop.tokenize = true;
```

### Enviando Dados do Cartão

```dart
var response = await sop.sendCardData(
    request: SilentOrderPostRequest(
        cardHolder: 'Darth Vader',
        cardNumber: '4111111111111111',
        cardExpirationDate: '01/2030',
        cardSecurityCode: '123')
        );
```

### Detalhamento Retorno de Erro

No caso de erro será retornado um objeto do tipo **SilentOrderPostException**. 
No exemplo abaixo foi capturado usando um FutureBuilder ou StreamBuilder:

```dart
...
if (snapshot.hasError) {
                    SilentOrderPostException errors = snapshot.error;
                    print('StatusCode: ${errors.statusCode}, '
                        'Message: ${errors.silentOrderPostError.message}, '
                        'Description: ${errors.silentOrderPostError.modelState.request}');
                    return Container();
                    }
...
```


## Manual

Para mais informações sobre a integração com o Silent Order Post, vide o manual em: [Silent Order Post](https://braspag.github.io//manualp/braspag-silent-order-post)