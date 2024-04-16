class ApiURLS {
  /// for testing mode
  static const domain = "https://api.sandbox.paypal.com";

//String domain = "https://api.paypal.com"; /// for production mode

  /// Change the clientId and secret given by PayPal to your own.
  static const clientId =
      'AbLx2Ge05BRCcYjAU4-ShGkM0w4XdQHDN7hfw3zEH263kTW6nuwBOoXL_5XJJKWwwVV8iW4j1FlderyM';
  static const secret =
      'EAFBMFvQqfvGb2y_flxhFTNFoxFqwJBn4ruGHO2f_zQHvQrDOxL8g4ufwz_rZwh5t6ltmluD02Jz4BPK';

  static const accessTokenURL =
      '$domain/v1/oauth2/token?grant_type=client_credentials';

  static const paymentURL = "$domain/v1/payments/payment";

  static const fetchPaymentInfoURLById =
      'https://api.sandbox.paypal.com/v1/payments/payment/';

  static const returnURL = 'https://api.sandbox.paypal.com/payment/success';
  static const cancelURL = 'https://api.sandbox.paypal.com/payment/cancel';
  static const fcmServerKey =
      'AAAAwZawCR8:APA91bGv744R5IO8MZdhSvTjkzoBgV7nPt33A4DO8F5Oopw8GWuFZEJ3Whnz_mf4NCYf0jOuy4MjiRKSgiUDxmZTyNmsAe7Gf_XdD9jI6wCx0VJ7mcxxl2ABFpQ5XDlu5TAK7c9JTmRR';

  ///Twilio for Phone Number
  // static const twilioBaseUrl = 'https://verify.twilio.com/v2/Services';
  static const twilioAccountSID = 'AC85aa66caf8609dffc06b92ede9d7af75';
  static const twilioAuthToken = 'fb700a8818cfb874b5683efdb4c5d02c';
  static const twilioAccountNumber = '+17866134009';
}
