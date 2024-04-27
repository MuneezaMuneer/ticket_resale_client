import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class AppBarPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController? controller;
  final SearchCallBack? setSearchQuery;
  final bool? isExpanded = true;
  AppBarPersistentHeaderDelegate({
    required this.controller,
    required this.setSearchQuery,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Calculate the opacity based on the scroll offset
    double opacity = shrinkOffset / (maxExtent - minExtent);
    // Interpolate color between white and blue based on opacity
    Color backgroundColor = AppColors.blueViolet.withOpacity(1 - opacity);
    Size size = MediaQuery.of(context).size;
    final double width = size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      // Use AnimatedOpacity to animate the visibility
      child: AnimatedOpacity(
        opacity: isExpanded! ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        const CustomText(
                          title: 'Discover Amazing',
                          color: AppColors.white,
                          size: AppFontSize.regular,
                          weight: FontWeight.w400,
                        ),
                        const CustomText(
                          title: 'Events Tickets Now',
                          color: AppColors.white,
                          size: AppFontSize.verylarge,
                          weight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color(0xffFFFFFF).withOpacity(0.1)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.chatScreen,
                      );
                    },
                    icon: Icon(
                      Icons.message_rounded,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            SizedBox(
              width: width * 0.9,
              child: CustomTextField(
                hintText: 'Search by Events, Tickets, or City',
                hintStyle: const TextStyle(
                  color: AppColors.silver,
                ),
                fillColor: AppColors.white,
                controller: controller!,
                isFilled: true,
                onChanged: (query) {
                  setSearchQuery!(controller!.text);
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: customGradient,
                    ),
                    child: Center(
                      child: controller!.text.isEmpty
                          ? const Icon(
                              Icons.search,
                              color: AppColors.white,
                            )
                          : InkWell(
                              onTap: () {
                                controller!.clear();
                                setSearchQuery!(controller!.text);
                              },
                              child: const Icon(
                                Icons.close,
                                color: AppColors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get minExtent => 10;
  @override
  double get maxExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate is AppBarPersistentHeaderDelegate) {
      return controller != oldDelegate.controller ||
          setSearchQuery != oldDelegate.setSearchQuery;
    }
    return false;
  }
}
