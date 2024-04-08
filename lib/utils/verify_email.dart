// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class EmailServices {
  static Future<bool> sendEmail({
    required String toEmail,
    required String fromEmail,
    required String subject,
    required String body,
    String? toEmailName,
    String? fromEmailName,
  }) async {
    try {
      const String url = 'https://api.sendgrid.com/v3/mail/send';
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer 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',
        },
        body: jsonEncode(
          {
            "personalizations": [
              {
                "to": [
                  {
                    "email": toEmail,
                    "name": toEmailName,
                  }
                ],
                "subject": subject
              }
            ],
            "content": [
              {
                "type": "text/plain",
                "value": body,
              }
            ],
            "from": {
              "email": fromEmail,
              "name": fromEmailName,
            },
          },
        ),
      );
      print('respone body of sending otp ${res.statusCode}  ${res.body}');
      if (res.statusCode == 200 || res.statusCode == 202) {
        print('respone body of sending otp ${res.body}');
        return true;
      }
    } catch (e) {
      print('respone body of sending error');
      return false;
    }
    return false;
  }

  static int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(9000) + 1000;
  }
}
