import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class PaymentConnectScreen extends StatelessWidget {
  const PaymentConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 234, 248),
      appBar: const CustomAppBar(
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
                          fontSize: AppSize.large)),
                  TextSpan(
                      text: '\nPaypal Account',
                      style: TextStyle(
                          color: AppColors.jetBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSize.verylarge)),
                  TextSpan(
                      text: '\nLorem ipsum dolor sit amet consectetur',
                      style: TextStyle(
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: AppSize.regular)),
                  TextSpan(
                      text: '\nadipiscing elit, sed do eiusmod.',
                      style: TextStyle(
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: AppSize.regular)),
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
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.disconnectScreen);
                },
                textColor: AppColors.white,
                textSize: AppSize.regular,
                isSocial: true,
                gradient: customGradient,
                isSvgImage: true,
                imagePath: AppSvgs.paypalIcon,
                socialText: 'Connect your account',
                socialTextColor: AppColors.white,
                socialTextWeight: FontWeight.w700,
                socialTextSize: AppSize.regular,
                weight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
