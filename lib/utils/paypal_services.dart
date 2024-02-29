import 'dart:math';

import 'package:flutter_paypal_native/flutter_paypal_native.dart';
import 'package:flutter_paypal_native/models/custom/currency_code.dart';
import 'package:flutter_paypal_native/models/custom/environment.dart';
import 'package:flutter_paypal_native/models/custom/order_callback.dart';
import 'package:flutter_paypal_native/models/custom/purchase_unit.dart';
import 'package:flutter_paypal_native/models/custom/user_action.dart';
import 'package:flutter_paypal_native/str_helper.dart';

class PayPalService {
  static final FlutterPaypalNative _flutterPaypalNativePlugin =
      FlutterPaypalNative.instance;
  PayPalService() {
    initPayPal();
  }

  void initPayPal() async {
    FlutterPaypalNative.isDebugMode = true;

    await _flutterPaypalNativePlugin.init(
      returnUrl: "https://sandbox.paypal.com",
      clientID: "AbLx2Ge05BRCcYjAU4-ShGkM0w4XdQHDN7hfw3zEH263kTW6nuwBOoXL_5XJJKWwwVV8iW4j1FlderyM",
      payPalEnvironment: FPayPalEnvironment.sandbox,
      currencyCode: FPayPalCurrencyCode.usd,
      action: FPayPalUserAction.payNow,
    );

    _flutterPaypalNativePlugin.setPayPalOrderCallback(
      callback: FPayPalOrderCallback(
        onCancel: () {
          print("Payment canceled");
        },
        onSuccess: (data) {
          _flutterPaypalNativePlugin.removeAllPurchaseItems();
          String visitor = data.cart?.shippingAddress?.firstName ?? 'Visitor';
          String address =
              data.cart?.shippingAddress?.line1 ?? 'Unknown Address';
          print(
            "Order successful ${data.payerId ?? ""} - ${data.orderId ?? ""} - $visitor -$address",
          );
        },
        onError: (data) {
          print("Payment error: ${data.reason}");
        },
        onShippingChange: (data) {
          print(
            "Shipping change: ${data.shippingChangeAddress?.adminArea1 ?? ""}",
          );
        },
      ),
    );
  }

  static void makePayPalPayment() {
    if (_flutterPaypalNativePlugin.canAddMorePurchaseUnit) {
      _flutterPaypalNativePlugin.addPurchaseUnit(
        FPayPalPurchaseUnit(
          amount: Random().nextDouble() * 100,
          referenceId: FPayPalStrHelper.getRandomString(16),
        ),
      );
    }
    _flutterPaypalNativePlugin.makeOrder(
      action: FPayPalUserAction.payNow,
    );
  }
}
