import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class SearchAppBar extends StatelessWidget {
  final TextEditingController searchController;
  final double width;
  final SearchCallBack setSearchQuery;
  final ValueNotifier<String> searchNotifier;

  const SearchAppBar({
    Key? key,
    required this.searchController,
    required this.width,
    required this.setSearchQuery,
    required this.searchNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double bottomPadding = deviceHeight <= 640 ? 17 : 20;

<<<<<<< HEAD
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
=======
    return SliverAppBar(
      pinned: true,
      expandedHeight: 150,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
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
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      backgroundColor: AppColors.blueViolet,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 17),
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
>>>>>>> 675ebc2b6bb3546ca6bc0947750051ea24f9cfdf
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: AppColors.purple, blurRadius: 20)],
                borderRadius: BorderRadius.all(Radius.circular(25))),
            width: width * 0.9,
            child: ValueListenableBuilder<String>(
              valueListenable: searchNotifier,
              builder: (context, searchText, _) {
                return CustomTextField(
                  hintText: 'Search Events, Tickets, or City',
                  hintStyle: const TextStyle(
                    color: AppColors.silver,
                  ),
                  fillColor: AppColors.white,
                  controller: searchController,
                  isFilled: true,
                  onChanged: (query) {
                    setSearchQuery(query);
                    searchNotifier.value = query;
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
                        child: searchText.isEmpty
                            ? const Icon(
                                Icons.search,
                                color: AppColors.white,
                              )
                            : InkWell(
                                onTap: () {
                                  searchController.clear();
                                  setSearchQuery('');
                                  searchNotifier.value = '';
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
