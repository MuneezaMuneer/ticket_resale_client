import 'package:flutter/material.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalAuthorization extends StatefulWidget {
  const PaypalAuthorization({
    Key? key,
  }) : super(key: key);

  @override
  State<PaypalAuthorization> createState() => _PaypalAuthorizationState();
}

class _PaypalAuthorizationState extends State<PaypalAuthorization> {
  late WebViewController controller;

  final clientID =
      'AUNeUFYbnJIJvGJQTkobZvaFbtxf-QD6BRutdQSxKdbZx6b0GWH8m0cZcAAczOei-pVQ4rVyEemcMRd4';

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('nativexo://paypalpay')) {
              AuthServices.storePaypalAuthorization(paypalAuthorization: true);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.sandbox.paypal.com/signin/authorize?client_id=$clientID&response_type=code&scope=openid&redirect_uri=nativexo://paypalpay'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: controller));
  }
}
