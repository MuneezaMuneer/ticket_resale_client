import 'dart:developer';
import 'dart:math' hide log;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:ticket_resale/constants/constants.dart';

class EmailServices {
  static Future<bool> sendVerificationEmail({
    required String toEmail,
    required String verificationCode,
    required String subject,
    String? toEmailName,
    String? fromEmailName = 'Rave Trade',
  }) async {
    final smtpServer = SmtpServer(
      ApiURLS.mailServer,
      username: ApiURLS.email,
      password: ApiURLS.pwd,
    );
    final message = Message()
      ..from = Address(ApiURLS.email, fromEmailName)
      ..subject = subject
      ..recipients = [toEmail]
      ..text = """Hey Fam! 🙌

Your email verification code for Rave Trade is: $verificationCode. Just enter it to get verified and you’ll be ready to go! 

PLUR 💗 - The Rave Trade Team""";

    try {
      final sendReport = await send(message, smtpServer);
      log('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      log('Message not sent.');
      for (var p in e.problems) {
        log('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }

  ///we are not using this service anymore as of client demand.
  // static Future<bool> sendEmail({
  //   required String toEmail,
  //   required String fromEmail,
  //   required String subject,
  //   required String body,
  //   String? toEmailName,
  //   String? fromEmailName,
  // }) async {
  //   try {
  //     const String url = 'https://api.sendgrid.com/v3/mail/send';
  //     final res = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization':
  //             'Bearer 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',
  //       },
  //       body: jsonEncode(
  //         {
  //           "personalizations": [
  //             {
  //               "to": [
  //                 {
  //                   "email": toEmail,
  //                   "name": toEmailName,
  //                 }
  //               ],
  //               "subject": subject
  //             }
  //           ],
  //           "content": [
  //             {
  //               "type": "text/plain",
  //               "value": body,
  //             }
  //           ],
  //           "from": {
  //             "email": fromEmail,
  //             "name": fromEmailName,
  //           },
  //         },
  //       ),
  //     );
  //     print('respone body of sending otp ${res.statusCode}  ${res.body}');
  //     if (res.statusCode == 200 || res.statusCode == 202) {
  //       print('respone body of sending otp ${res.body}');
  //       return true;
  //     }
  //   } catch (e) {
  //     print('respone body of sending error');
  //     return false;
  //   }
  //   return false;
  // }

  static int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(9000) + 1000;
  }
}
