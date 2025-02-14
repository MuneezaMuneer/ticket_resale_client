import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomTileContainer extends StatelessWidget {
  final double? width;
  final String? date;
  final String? time;
  final String? posttitle;
  final String? postBy;
  final double? height;
  final String? imagePath;
  const CustomTileContainer({
    Key? key,
    this.width,
    this.date,
    this.posttitle,
    this.time,
    this.postBy,
    this.imagePath,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(left: 7, right: 7, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                          height: constraints.maxHeight * 0.44,
                          width: constraints.maxWidth,
                          child: Image.network(
                            imagePath!,
                            fit: BoxFit.cover,
                          )),
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
                              child: Row(
                                children: [
                                  CustomText(
                                    title: '$date,',
                                    color: const Color(0Xff6E4CEE),
                                    size: AppFontSize.xxsmall,
                                    weight: FontWeight.w600,
                                  ),
                                  const Gap(6),
                                  CustomText(
                                    title: '$time',
                                    color: const Color(0Xff6E4CEE),
                                    size: AppFontSize.xxsmall,
                                    weight: FontWeight.w600,
                                  ),
                                ],
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
                      textAlign: TextAlign.start,
                      color: AppColors.jetBlack,
                      size: AppFontSize.regular,
                      weight: FontWeight.w600,
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
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pushNamed(
                          context,
                          AppRoutes.eventScreen,
                          arguments: true,
                        );
                      },
                      textColor: AppColors.white,
                      textSize: AppFontSize.medium,
                      gradient: customGradient,
                      isRounded: false,
                      isSvgImage: true,
                      btnText: 'Explore More',
                      socialTextColor: AppColors.white,
                      socialTextWeight: FontWeight.w700,
                      socialTextSize: AppFontSize.verySmall,
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
