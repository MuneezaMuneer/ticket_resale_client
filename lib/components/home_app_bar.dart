// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

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
      padding: EdgeInsets.symmetric(horizontal: 13),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.chatScreen,
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white.withOpacity(0.1),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.comment,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
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

// class SearchQueryHeader extends SliverPersistentHeaderDelegate {
//   final TextEditingController? controller;
//   final SearchCallBack? setSearchQuery;

//   SearchQueryHeader({
//     required this.controller,
//     required this.setSearchQuery,
//   });

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     Size size = MediaQuery.of(context).size;
//     final double width = size.width;

//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.blueViolet,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(40),
//           bottomRight: Radius.circular(40),
//         ),
//       ),
//       child: Align(
//         alignment: Alignment.center,
//         child: SizedBox(
//           width: width * 0.9,
//           child: ValueListenableBuilder(
//             valueListenable: controller!,
//             builder: (context, value, child) {
//               return CustomTextField(
//                 hintText: 'Search Events, Tickets, or City',
//                 hintStyle: const TextStyle(
//                   color: AppColors.silver,
//                 ),
//                 fillColor: AppColors.white,
//                 controller: controller!,
//                 isFilled: true,
//                 onChanged: (query) {
//                   setSearchQuery!(controller!.text);
//                 },
//                 suffixIcon: Padding(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: Container(
//                     height: 35,
//                     width: 35,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: customGradient,
//                     ),
//                     child: Center(
//                       child: controller!.text.isEmpty
//                           ? const Icon(
//                               Icons.search,
//                               color: AppColors.white,
//                             )
//                           : InkWell(
//                               onTap: () {
//                                 controller!.clear();
//                                 setSearchQuery!(controller!.text);
//                               },
//                               child: const Icon(
//                                 Icons.close,
//                                 color: AppColors.white,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   double get minExtent => 50;
//   @override
//   double get maxExtent => 75;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     if (oldDelegate is SearchQueryHeader) {
//       return controller != oldDelegate.controller ||
//           setSearchQuery != oldDelegate.setSearchQuery;
//     }
//     return false;
//   }
// }
