// import 'package:flutter_idensic_mobile_sdk_plugin/flutter_idensic_mobile_sdk_plugin.dart';
// import 'dart:ui';
// import 'package:http/http.dart' as http;


// class SumsubServices {
//   static void launchSDK() async {
//     final String accessToken =
//         "sbx:jQ4mHrvbwDCDx6xMrdg0dYAL.NJXWzbSqabhGkgxxe4Aaeo5kV3NHIJHc"; // Replace with your actual access token



//   // Function to fetch a new access token from your backend
//   Future<String> fetchNewAccessToken() async {
//     final response = await http.get(Uri.parse('your_backend_endpoint')); // Replace 'your_backend_endpoint' with the actual URL of your backend endpoint
//     if (response.statusCode == 200) {
//       // If the request is successful, parse the response and return the new access token
//       return response.body;
//     } else {
//       // If the request fails, handle the error accordingly (e.g., retry, show an error message)
//       throw Exception('Failed to fetch new access token');
//     }
//   }

//   // Function to handle token expiration and fetch a new access token
//   final onTokenExpiration = () async {
//     try {
//       // Call the function to fetch a new access token from your backend
//       String newAccessToken = await fetchNewAccessToken();
//       return newAccessToken;
//     } catch (error) {
//       // Handle any errors that occur during the token expiration handling
//       print('Error fetching new access token: $error');
//       // Return null or throw an error if unable to fetch a new access token
//       return null;
//     }
//   };
//     // final onTokenExpiration = () async {
//     //   // You may implement logic here to fetch a new access token from your backend
//     //   return Future<String>.delayed(
//     //       Duration(seconds: 2), () => "your_new_access_token");
//     // };

//     final SNSStatusChangedHandler onStatusChanged =
//         (SNSMobileSDKStatus newStatus, SNSMobileSDKStatus prevStatus) {
//       print("The SDK status was changed: $prevStatus -> $newStatus");
//     };

//     final snsMobileSDK = SNSMobileSDK.init(accessToken, onTokenExpiration)
//         .withHandlers(
//           onStatusChanged: onStatusChanged,
//         )
//         .withDebug(true)
//         .withLocale(Locale("en"))
//         .build();

//     final SNSMobileSDKResult result = await snsMobileSDK.launch();

//     print("Completed with result: $result");
//   }
// }
