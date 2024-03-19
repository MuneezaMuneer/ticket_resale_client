// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/screens/screens.dart';
import 'package:ticket_resale/utils/app_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String totalPrice;
  final List<Map<String, dynamic>> items;
  final List<String> docIds;
  final String hashKey;

  // final Function(String?) onFinish;
  const PaymentScreen({
    super.key,
    // required this.onFinish,
    required this.items,
    required this.totalPrice,
    required this.docIds,
    required this.hashKey,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    PaypalPaymentServices.getAccessToken().then((accessToken) async {
      final res = await PaypalPaymentServices.createPaypalPayment(
          item: widget.items,
          token: accessToken!,
          totalPrice: widget.totalPrice);
      if (res != null) {
        setState(() {
          checkoutUrl = res["approvalUrl"];
          executeUrl = res["executeUrl"];
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
                  log('...................login urls ==  ${request.url}');

                  if (request.url.contains(ApiURLS.returnURL)) {
                    final uri = Uri.parse(request.url);
                    final payerID = uri.queryParameters['PayerID'];
                    log(".....................ID for Transaction........$executeUrl");

                    if (payerID != null) {
                      PaypalPaymentServices.executePayment(
                              executeUrl, payerID, accessToken)
                          .then((id) {
                        log(".....................Payment Id : $id");

                        FireStoreServices.updateStatusInSoldTicketsCollection(
                                hashKey: widget.hashKey,
                                selectedDocIds: widget.docIds,
                                newStatus: 'Paid')
                            .then((value) {
                          AppUtils.toastMessage('Payment Done Successfully');
                        });
                        //  widget.onFinish(id);
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                    Navigator.of(context).pop();
                  }
                  if (request.url.contains(ApiURLS.cancelURL)) {
                    Navigator.of(context).pop();
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse('$checkoutUrl'));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: const Center(child: CupertinoActivityIndicator()),
      );
    }
  }
}
