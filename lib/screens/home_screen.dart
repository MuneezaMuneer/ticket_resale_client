import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List namesDJS = [
      "Adele",
      "Ed Sheeran",
      "Beyoncé",
      "Justin Bieber",
    ];

    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: height * 0.27,
                width: width,
                decoration: BoxDecoration(
                    gradient: customGradient,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 40, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              circleAvatar(48, 48, AppImages.profile),
                              const Padding(
                                padding: EdgeInsets.only(left: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: 'Good Morning,',
                                      color: AppColors.white,
                                      weight: FontWeight.w400,
                                      size: AppSize.xsmall,
                                    ),
                                    CustomText(
                                      title: 'Kathrine Margot',
                                      color: AppColors.white,
                                      weight: FontWeight.w700,
                                      size: AppSize.xmedium,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.menu,
                            color: AppColors.white,
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      const CustomText(
                        title: 'Discover Amazing',
                        color: AppColors.white,
                        size: AppSize.xmedium,
                        weight: FontWeight.w400,
                      ),
                      const CustomText(
                        title: 'Events Ticket Now',
                        color: AppColors.white,
                        size: AppSize.large,
                        weight: FontWeight.w700,
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.24,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: height * 0.07,
                      width: width * 0.8,
                      child: CustomTextField(
                        borderColor: AppColors.silver.withOpacity(0.3),
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
                  const Gap(15),
                  const CustomText(
                    title: 'Upcoming Event Tickets',
                    color: AppColors.jetBlack,
                    size: AppSize.xmedium,
                    weight: FontWeight.w600,
                  ),
                  const Gap(15),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(AppImages.homeConcert)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: 150,
                            child: AvatarStack(
                              height: 50,
                              avatars: [
                                for (var n = 0; n < 17; n++)
                                  const AssetImage(AppImages.profile),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        bottom: -35,
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.8,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.silver.withOpacity(0.3)),
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 10, left: 15),
                                child: CustomText(
                                  title: 'Event Name Here',
                                  color: AppColors.jetBlack,
                                  size: 15,
                                  weight: FontWeight.w700,
                                ),
                              ),
                              const Gap(5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                  
                                    rowText('25th jan - 31st jan'),
                                    rowText('8:00 PM - 11:00 PM')
                                  
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.065,
                  ),
                  const CustomText(
                    title: 'Popular DJS',
                    color: AppColors.jetBlack,
                    size: AppSize.xmedium,
                    weight: FontWeight.w600,
                  ),
                  const Gap(15),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: namesDJS.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: height * 0.07,
                          width: width * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color:
                                          AppColors.lightGrey.withOpacity(0.2)),
                                  color: AppColors.paleGrey.withOpacity(0.2)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    child:
                                        circleAvatar(50, 50, AppImages.profile),
                                  ),
                                  const Gap(10),
                                  CustomText(
                                    title: namesDJS[index],
                                    color: AppColors.jetBlack.withOpacity(0.7),
                                    size: AppSize.xxsmall,
                                    weight: FontWeight.w600,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    height: height * 0.43,
                    width: width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CustomTileContainer(
                              width: width * 0.65,
                              dateTime: '25th Janurary 8:00 AM - 12:00 AM',
                              posttitle:
                                  'Happy Holiday Music Concert Global Village',
                              postBy: 'Jacob Jones',
                              imagePath: AppImages.profile,
                            ));
                      },
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget circleAvatar(double height, double width, String imagePath) {
  return SizedBox(
    height: height,
    width: width,
    child: CircleAvatar(
      backgroundImage: AssetImage(imagePath),
    ),
  );
}

Widget rowText(String title) {
  return Row(
    children: [
      SvgPicture.asset(AppSvgs.calender),
      Padding(
        padding: const EdgeInsets.only(left: 7),
        child: CustomText(
          title: title,
          color: AppColors.lightGrey,
          size: AppSize.xsmall,
          weight: FontWeight.w400,
        ),
      )
    ],
  );
}
