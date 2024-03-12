import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';

class PaypalPaymentServices {
  /// for testing mode
  String domain = "https://api.sandbox.paypal.com";

//String domain = "https://api.paypal.com"; /// for production mode

  /// Change the clientId and secret given by PayPal to your own.
  String clientId =
      'AbLx2Ge05BRCcYjAU4-ShGkM0w4XdQHDN7hfw3zEH263kTW6nuwBOoXL_5XJJKWwwVV8iW4j1FlderyM';
  String secret =
      'EAFBMFvQqfvGb2y_flxhFTNFoxFqwJBn4ruGHO2f_zQHvQrDOxL8g4ufwz_rZwh5t6ltmluD02Jz4BPK';

  /// for obtaining the access token from Paypal
  Future<String?> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
        Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'),
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
  Future<Map<String, String>?> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });
      log(".......................Response : ${response.body}");
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
  Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken',
          });

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchPaymentDetails(String paymentId) async {
    final String apiUrl =
        'https://api.sandbox.paypal.com/v1/payments/payment/$paymentId';
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
}
