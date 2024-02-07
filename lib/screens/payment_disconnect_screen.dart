import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/utils/app_dialouge.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class PaymentDisconnectScreen extends StatelessWidget {
  const PaymentDisconnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
        body: Column(
      children: [
        const CustomAppBar(
          title: 'Payment Method',
        ),
        SizedBox(
          height: height * 0.1,
        ),
        SizedBox(
            height: height * 0.32, child: SvgPicture.asset(AppSvgs.paypal)),
        SizedBox(
          height: height * 0.05,
        ),
        RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: 'Paypal Account',
                style: TextStyle(
                    color: AppColors.jetBlack,
                    fontWeight: FontWeight.w400,
                    fontSize: AppSize.large)),
            TextSpan(
                text: '\nis connected',
                style: TextStyle(
                    color: AppColors.jetBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSize.verylarge)),
            TextSpan(
                text: '\njohnDoe@gmail.com',
                style: TextStyle(
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: AppSize.regular)),
            TextSpan(
                text: '\nConnected: 29th Feb 2032',
                style: TextStyle(
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: AppSize.regular)),
          ]),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        SizedBox(height: height * 0.07),
        SizedBox(
          height: height * 0.07,
          width: width * 0.8,
          child: CustomButton(
            onPressed: () {
              deleteDialog(context: context);
            },
            textColor: AppColors.white,
            textSize: AppSize.regular,
            isSocial: true,
            gradient: customGradient,
            isSvgImage: true,
            imagePath: AppSvgs.paypalIcon,
            socialText: 'Disconnect your account',
            socialTextColor: AppColors.white,
            socialTextWeight: FontWeight.w700,
            socialTextSize: AppSize.regular,
            weight: FontWeight.w700,
          ),
        )
      ],
    ));
  }
}
