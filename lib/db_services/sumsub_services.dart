import 'dart:convert';
import 'dart:developer';

import 'package:flutter_idensic_mobile_sdk_plugin/flutter_idensic_mobile_sdk_plugin.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;

class SumsubServices {
  Future<String> fetchNewAccessToken(String idCard) async {
    print('The id card is $idCard');
    final response = await http.post(
      Uri.parse(
          'https://api.sumsub.com/resources/accessTokens?userId=$idCard&levelName=id-verify'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer sbx:463eKfxrFsvrvYAmaCyuquiH.krrsBzMrjXpcW5Qd1yFgP4xWVZn9d2DY',
      },
    );
    log("statusCode: ${response.statusCode} body : ${response.body}");

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result["token"];
    } else {
      throw Exception('Failed to fetch new access token');
    }
  }

  Future<String> onTokenExpiration() async {
    try {
      String newAccessToken =
          await fetchNewAccessToken("6640e2aa1f8d1169713c7d85");
      return newAccessToken;
    } catch (error) {
      print('Error fetching new access token: $error');
      return ""; // Or handle the error accordingly
    }
  }

  static void launchSDK(
      String accessToken, Future<String?> Function() tokenExpiration) async {
    final SNSStatusChangedHandler onStatusChanged =
        (SNSMobileSDKStatus newStatus, SNSMobileSDKStatus prevStatus) {
      print("The SDK status was changed: $prevStatus -> $newStatus");
    };

    try {
      final snsMobileSDK = SNSMobileSDK.init(accessToken, tokenExpiration)
          .withHandlers(
            onStatusChanged: onStatusChanged,
          )
          .withDebug(true)
          .withLocale(Locale("en"))
          .build();

      final SNSMobileSDKResult result = await snsMobileSDK.launch();

      print("Completed with result: $result");
    } catch (error) {
      print('Error launching SDK: $error');
      // Handle the error accordingly
    }
  }
}
