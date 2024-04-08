import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class PaymentConnectScreen extends StatefulWidget {
  const PaymentConnectScreen({super.key});

  @override
  State<PaymentConnectScreen> createState() => _PaymentConnectScreenState();
}

class _PaymentConnectScreenState extends State<PaymentConnectScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 230, 234, 248),
      appBar: const CustomAppBarClient(
        title: 'Payment Method',
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            SizedBox(
                height: height * 0.32,
                child: Image.asset(AppImages.creditCard)),
            SizedBox(
              height: height * 0.05,
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'Connect Your',
                      style: TextStyle(
                          color: AppColors.jetBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFontSize.large)),
                  TextSpan(
                      text: '\nPaypal Account',
                      style: TextStyle(
                          color: AppColors.jetBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.verylarge)),
                  TextSpan(
                      text: '\nLorem ipsum dolor sit amet consectetur',
                      style: TextStyle(
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFontSize.regular)),
                  TextSpan(
                      text: '\nadipiscing elit, sed do eiusmod.',
                      style: TextStyle(
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFontSize.regular)),
                ],
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            SizedBox(height: height * 0.07),
            SizedBox(
              height: height * 0.07,
              width: width * 0.8,
              child: CustomButton(
                onPressed: () async {
                  // PaypalPaymentServices paypalServices =
                  //     PaypalPaymentServices();
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => PaymentScreen(
                  //       onFinish: (paymentId) async {
                  //         paypalServices.fetchPaymentDetails("$paymentId");
                  //         final snackBar = SnackBar(
                  //           content: const Text("Payment done Successfully"),
                  //           duration: const Duration(seconds: 5),
                  //           action: SnackBarAction(
                  //             label: 'Close',
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //           ),
                  //         );
                  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //       },
                  //     ),
                  //   ),
                  // );
                  Navigator.pushNamed(context, AppRoutes.payPalAuthorization);
                },
                textColor: AppColors.white,
                textSize: AppFontSize.regular,
                isSocial: true,
                gradient: customGradient,
                isSvgImage: true,
                imagePath: AppSvgs.paypalIcon,
                socialText: 'Connect your account',
                socialTextColor: AppColors.white,
                socialTextWeight: FontWeight.w700,
                socialTextSize: AppFontSize.regular,
                weight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
