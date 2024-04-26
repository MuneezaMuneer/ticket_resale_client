import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

final String SUMSUB_APP_TOKEN =
    'sbx:XmfqDTQskwOMce9Hct3na1wr.56SSn4gQKJT4qcJxux4ovXpzLAybJP2i';
final String SUMSUB_SECRET_KEY = 'LrF31Qw5O3E0Bk2k0w88Kxwqxd4ri6l2';
final String SUMSUB_BASE_URL = 'https://api.sumsub.com';

String generateSignature(String method, String url, String ts, [String? body]) {
  var hmacSha256 = Hmac(sha256, utf8.encode(SUMSUB_SECRET_KEY));
  var bytes = utf8.encode(ts + method.toUpperCase() + url + (body ?? ''));
  var digest = hmacSha256.convert(bytes);
  return digest.toString();
}

String generateExternalUserId() {
  // Generate a unique identifier using UUID (Universally Unique Identifier)
  var uuid = Uuid();
  return uuid.v4();
}

Future<Map<String, dynamic>> createAccessToken(
  String levelName,
  int ttlInSecs,
) async {
  final externalUserId = generateExternalUserId();
  final ts = (DateTime.now().millisecondsSinceEpoch / 1000).floor().toString();
  final url =
      '$SUMSUB_BASE_URL/resources/accessTokens?userId=${Uri.encodeComponent(externalUserId)}&ttlInSecs=$ttlInSecs&levelName=${Uri.encodeComponent(levelName)}';
  final signature = generateSignature('post', url, ts);
  final headers = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $SUMSUB_APP_TOKEN',
    'X-App-Access-Ts': ts,
    'X-App-Access-Sig': signature,
  };
  final response = await http.post(Uri.parse(url), headers: headers);
  log('jason body response: ${jsonDecode(response.body)}');
  return jsonDecode(response.body);
}
