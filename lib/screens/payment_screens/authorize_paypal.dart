import 'package:flutter/cupertino.dart';
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
  bool isLoading = true;

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
            setState(() {
              isLoading = progress < 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('nativexo://paypalpay')) {
              AuthServices.verifyBadge(isPaypalAuthorized: true);
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
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            Center(
              child: CupertinoActivityIndicator(),
            ),
        ],
      ),
    );
  }
}
