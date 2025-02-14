// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/screens/screens.dart';
import 'package:ticket_resale/utils/custom_snackbar.dart';
import 'package:ticket_resale/utils/notification_services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  final String totalPrice;
  final List<Map<String, dynamic>> items;
  final List<String> docIds;
  final String hashKey;
  final UserModelClient userModel;
  final String ticketImage;
  final String ticketPrice;
  final String ticketName;
  // final Function(String?) onFinish;
  const PaymentScreen(
      {super.key,
      // required this.onFinish,
      required this.items,
      required this.totalPrice,
      required this.docIds,
      required this.hashKey,
      required this.userModel,
      required this.ticketImage,
      required this.ticketPrice,
      required this.ticketName});

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
                onNavigationRequest: (NavigationRequest request) async {
                  log('...................login urls ==  ${request.url}');

                  if (request.url.contains(ApiURLS.returnURL)) {
                    final uri = Uri.parse(request.url);
                    final payerID = uri.queryParameters['PayerID'];
                    final paymentId = uri.queryParameters['paymentId'];
                    late final paypalEmail;
                    late final allUserPaypalEmails;
                    final accessToken =
                        await PaypalPaymentServices.getAccessToken();
                    print('Access Token: $accessToken');
                    final response = await http.get(
                      Uri.parse('${ApiURLS.fetchPaymentInfoURLById}$paymentId'),
                      headers: {
                        'Authorization': 'Bearer $accessToken',
                        'Content-Type': 'application/json',
                      },
                    );

                    if (response.statusCode == 200) {
                      final responseData = json.decode(response.body);
                      print('PayPal Response Data: $responseData');

                      final payerInfo = responseData['payer']['payer_info'];
                      paypalEmail = payerInfo['email'];
// Function to fetch PayPal email of all users from Firestore
                      allUserPaypalEmails = await FireStoreServicesClient
                          .getAllUserPaypalEmails();
                      ;
                      if (paypalEmail != null &&
                          !allUserPaypalEmails.contains(paypalEmail)) {
                        await FireStoreServicesClient.storeUserPaypalInfo(
                            email: paypalEmail);
                      }
                    }

                    final currentUserPaypalEmail = paypalEmail;

                    if (

// Function to check if a PayPal email is already in use by another user
                        FireStoreServicesClient.isPaypalEmailAlreadyInUse(
                            currentUserPaypalEmail, allUserPaypalEmails)) {
                      SnackBarHelper.showSnackBar(context,
                          'PayPal email is already in use by another user. Payment cannot proceed.');
                    } else {
                      log(".....................ID for Transaction........$executeUrl");
                      NotificationModel notificationModel = NotificationModel(
                        title: 'Payment Done Successfully',
                        body:
                            "The offered'\$${widget.totalPrice}' price is paid successfully",
                        eventId: AuthServices.getCurrentUser.uid,
                        userId: widget.userModel.id,
                        status: 'Unread',
                        notificationType: 'paid',
                        // docId: AuthServices.getCurrentUser.uid,
                      );
                      if (payerID != null) {
                        await PaypalPaymentServices.executePayment(
                                executeUrl, payerID, accessToken)
                            .then((id) async {
                          await FireStoreServicesClient
                              .updateNumberOfTransactions(
                                  userId1: AuthServices.userUid,
                                  userId2: widget.userModel.id!);
                          log(".....................Payment Id : $id");
                          print(
                              'The notification of paid ticket is ${widget.userModel.fcmToken}');
                          await NotificationServices.sendNotification(
                              token: widget.userModel.fcmToken!,
                              title: 'Payment Done Successfully',
                              body:
                                  "The offered'\$${widget.totalPrice}' price is paid successfully",
                              data: notificationModel.toMapForNotifications());
                          TicketsSoldModel soldModel = TicketsSoldModel(
                            ticketPrice: widget.ticketPrice,
                            ticketImage: widget.ticketImage,
                            ticketName: widget.ticketName,
                            buyerUid: AuthServices.getCurrentUser.uid,
                          );
                          await FireStoreServicesClient.storeSoldTickets(
                            soldModel: soldModel,
                            userId: widget.userModel.id!,
                          ).then((value) async {
                            await FireStoreServicesClient
                                .updateStatusInSoldTicketsCollection(
                              hashKey: widget.hashKey,
                              selectedDocIds: widget.docIds,
                              newStatus: 'Unpaid',
                            ).then((value) async {
                              await FireStoreServicesClient.storeNotifications(
                                  notificationModel: notificationModel,
                                  name: 'client_notifications');
                            });
                          });

                          //  widget.onFinish(id);
                          if (mounted) {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.feedbackScreen,
                                arguments: {
                                  'sellerImageUrl': widget.userModel.photoUrl,
                                  'sellerName': widget.userModel.displayName,
                                  'sellerId': widget.userModel.id
                                });
                          }
                        });
                      } else {
                        Navigator.of(context).pop();
                      }
                    }

                    // Navigator.of(context).pop();
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
          backgroundColor: Theme.of(context).colorScheme.surface,
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
