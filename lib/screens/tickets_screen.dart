import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.paleGrey,
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Event Video Player',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: width * 0.9,
                      child: CustomTextField(
                        borderColor: AppColors.silver.withOpacity(0.5),
                        hintText: 'Search Event & Tickets',
                        fillColor: AppColors.white,
                        isFilled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: customGradient,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.search,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  const CustomText(
                    title: 'All Tickets',
                    color: AppColors.jetBlack,
                    size: AppSize.xmedium,
                    weight: FontWeight.w600,
                  ),
                  const Gap(5),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 4,
                              crossAxisCount: 2,
                              mainAxisExtent: 250),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.silver.withOpacity(0.7),
                            ),
                            color: AppColors.white,
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5),
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
                                        color: AppColors.lightGrey
                                            .withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2),
                                              child: SvgPicture.asset(
                                                  AppSvgs.clock),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 2),
                                              child: CustomText(
                                                title:
                                                    '25th Jan 8:00pm-11:00pm',
                                                color: Color(0Xff6E4CEE),
                                                size: AppSize.xxsmall,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(8),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: CustomText(
                                        title:
                                            'Happy Holiday Music Concert Global Village',
                                        color: AppColors.jetBlack,
                                        size: AppSize.xsmall,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, top: 5),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  AssetImage(AppImages.profile),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Posted by ',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.lightGrey,
                                                      fontSize: AppSize.xxsmall,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Jacob Jones',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.lightGrey,
                                                      fontSize: AppSize.xxsmall,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Positioned(
                              //   bottom: 0,
                              //   left: 0,
                              //   right: 0,
                              //   child: CustomContainer(
                              //     height: 30,
                              //     isRounded: false,
                              //     width: width,
                              //     text: 'Explore More',
                              //     color: AppColors.white,
                              //     weight: FontWeight.w600,
                              //     size: AppSize.xsmall,
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
