import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomTileContainer extends StatelessWidget {
  final double? width;
  final String? dateTime;
  final String? posttitle;
  final String? postBy;
  final double? height;
  final String? imagePath;

  const CustomTileContainer({
    super.key,
    this.width,
    this.dateTime,
    this.posttitle,
    this.postBy,
    this.imagePath,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.silver.withOpacity(0.7),
            ),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(AppImages.concert),
                    ),
                    const Gap(10),
                    Container(
                      height: 25,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56),
                        color: AppColors.lightGrey.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            const Gap(10),
                            SvgPicture.asset(AppSvgs.clock),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CustomText(
                                title: '$dateTime',
                                color: const Color(0Xff6E4CEE),
                                size: AppSize.xxsmall,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(5),
                    CustomText(
                      title: '$posttitle',
                      color: AppColors.jetBlack,
                      size: AppSize.small,
                      weight: FontWeight.w600,
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('$imagePath'),
                          ),
                        ),
                        const Gap(10),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Posted by ',
                                style: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontSize: AppSize.xxsmall,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextSpan(
                                text: postBy,
                                style: const TextStyle(
                                  color: AppColors.lightGrey,
                                  fontSize: AppSize.xxsmall,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
       
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 40,
            child: CustomButton(
              onPressed: () {},
              textColor: AppColors.white,
              textSize: AppSize.xmedium,
              isSocial: true,
              gradient: customGradient,
              isRounded: false,
              isSvgImage: true,
              imagePath: AppSvgs.paypalIcon,
              socialText: 'Connect your account',
              socialTextColor: AppColors.white,
              socialTextWeight: FontWeight.w700,
              socialTextSize: AppSize.xmedium,
              weight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}
