import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalAuthorization extends StatefulWidget {
  const PaypalAuthorization({Key? key, required this.title}) : super(key: key);
  final String title;

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
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('nativexo://paypalpay')) {
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: WebViewWidget(controller: controller));
  }
}
