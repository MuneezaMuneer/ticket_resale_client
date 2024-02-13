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
    Key? key,
    this.width,
    this.dateTime,
    this.posttitle,
    this.postBy,
    this.imagePath,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('width is ...........................$width');
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0XffEAE6F4),
            ),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                          height: constraints.maxHeight * 0.4,
                          width: constraints.maxWidth,
                          child: Image.asset(
                            AppImages.concert,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.02,
                    ),
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
                    SizedBox(
                      height: constraints.maxHeight * 0.02,
                    ),
                    CustomText(
                      title: '$posttitle',
                      softWrap: true,
                      color: AppColors.jetBlack,
                      size: AppSize.regular,
                      weight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.02,
                    ),
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
              SizedBox(
                height: constraints.maxHeight * 0.01,
              ),
              Flexible(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 40,
                    child: CustomButton(
                      onPressed: () {},
                      textColor: AppColors.white,
                      textSize: AppSize.medium,
                      gradient: customGradient,
                      isRounded: false,
                      isSvgImage: true,
                      btnText: 'Explore More',
                      socialTextColor: AppColors.white,
                      socialTextWeight: FontWeight.w700,
                      socialTextSize: AppSize.verySmall,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
