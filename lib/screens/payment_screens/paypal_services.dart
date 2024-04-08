import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'package:ticket_resale/constants/constants.dart';

class PaypalPaymentServices {
  /// for obtaining the access token from Paypal
  static Future<String?> getAccessToken() async {
    try {
      var client = BasicAuthClient(ApiURLS.clientId, ApiURLS.secret);
      var response = await client.post(
        Uri.parse(ApiURLS.accessTokenURL),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for generating the PayPal payment request
  static Future<Map<String, String>?> createPaypalPayment(
      {required String token,
      required String totalPrice,
      required List<Map<String, dynamic>> item}) async {
    try {
      var response = await http.post(Uri.parse(ApiURLS.paymentURL),
          body: jsonEncode(_getOrderBody(totalPrice: totalPrice, items: item)),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token'
          });
      log("................create payment Response : ${response.body}");
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          log("..................URLs............${{
            "executeUrl": executeUrl,
            "approvalUrl": approvalUrl
          }}");
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// for carrying out the payment process
  static Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken',
          });

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log('...........payment done body = ${response.body}');
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> fetchPaymentDetails(
      String paymentId) async {
    final String apiUrl = '${ApiURLS.fetchPaymentInfoURLById}$paymentId';
    final String? accessToken =
        await getAccessToken(); // Replace with your actual access token

    if (accessToken == null) {
      throw Exception('Access token is null');
    }

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );
    log("..................Response of transaction details : ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      log('Failed to fetch payment details. Status code: ${response.statusCode}, Body: ${response.body}');
      throw Exception('Failed to fetch payment details');
    }
  }

  static Map<String, dynamic> _getOrderBody(
      {required String totalPrice, required List<Map<String, dynamic>> items}) {
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    // String userFirstName = 'Muneeza';
    // String userLastName = 'Muneer';
    // String addressCity = 'USA';
    // String addressStreet = "i-10";
    // String addressZipCode = '44000';
    // String addressCountry = 'Pakistan';
    // String addressState = 'Islamabad';
    // String addressPhoneNumber = '3095237159';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalPrice,
            "currency": 'USD',
            "details": {
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {"items": items},
          // if (isEnableShipping && isEnableAddress)
          //   "shipping_address": {
          //     "recipient_name": "$userFirstName $userLastName",
          //     "line1": addressStreet,
          //     "line2": "",
          //     "city": addressCity,
          //     "country_code": addressCountry,
          //     "postal_code": addressZipCode,
          //     "phone": addressPhoneNumber,
          //     "state": addressState
          //   },
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": ApiURLS.returnURL,
        "cancel_url": ApiURLS.cancelURL
      }
    };
    return temp;
  }
}
