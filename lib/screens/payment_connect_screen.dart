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
      body: Center(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Payment Method',
            ),
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
              text: const TextSpan(children: [
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
                        fontSize: AppSize.xxlarge)),
                TextSpan(
                    text: '\nLorem ipsum dolor sit amet consectetur',
                    style: TextStyle(
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.xmedium)),
                TextSpan(
                    text: '\nadipiscing elit, sed do eiusmod.',
                    style: TextStyle(
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.xmedium)),
              ]),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            SizedBox(height: height * 0.07),
            // CustomContainer(
            //   height: height * 0.07,
            //   width: width * 0.8,
            //   isSocial: true,
            //   socialText: 'Connect your account',
            //   imagePath: AppSvgs.paypalIcon,
            //   color: AppColors.white,
            //   weight: FontWeight.w700,
            //   size: AppSize.xmedium,
            // ),
            SizedBox(
              height: height * 0.07,
              width: width * 0.8,
              child: CustomButton(
                onPressed: () {},
                textColor: AppColors.white,
                textSize: AppSize.xmedium,
                isSocial: true,
                gradient: customGradient,
                isSvgImage: true,
                imagePath: AppSvgs.paypalIcon,
                socialText: 'Connect your account',
                weight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
