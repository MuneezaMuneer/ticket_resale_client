// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController? controller;
  final SearchCallBack? setSearchQuery;
  const HomeAppBar({
    Key? key,
    required this.controller,
    required this.setSearchQuery,
  }) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(170);
}

class _HomeAppBarState extends State<HomeAppBar> {
  String? displayName;
  String? photoUrl;

  ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
  late Stream<List<EventModalClient>> displayEventData;

  @override
  void initState() {
    displayName = AuthServices.getCurrentUser.displayName ?? '';
    photoUrl = AuthServices.getCurrentUser.photoURL ?? '';
    displayEventData = FireStoreServicesClient.fetchEventData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Container(
      width: width,
      decoration: BoxDecoration(
          gradient: customGradient,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
                height: 50,
                width: 50,
                child: photoUrl != null && photoUrl!.isNotEmpty
                    ? CustomDisplayStoryImage(
                        imageUrl: '$photoUrl',
                        height: 45,
                        width: 45,
                      )
                    : const CircleAvatar(
                        backgroundImage: AssetImage(AppImages.profileImage))),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: AppUtils.getGreeting(),
                    color: AppColors.white,
                    weight: FontWeight.w400,
                    size: AppSize.small,
                  ),
                  CustomText(
                    title: displayName != null ? displayName ?? '' : '',
                    color: AppColors.white,
                    weight: FontWeight.w700,
                    size: AppSize.regular,
                  )
                ],
              ),
            ),
            Positioned(
              right: 5,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.notificationScreen,
                  );
                },
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(AppSvgs.sms),
                    )),
              ),
            ),
            Positioned(
              right: 5,
              top: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.chatScreen);
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
                    )),
              ),
            ),
            Positioned(
              top: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'Discover Amazing',
                    color: AppColors.white,
                    size: AppSize.regular,
                    weight: FontWeight.w400,
                  ),
                  const CustomText(
                    title: 'Events Tickets Now',
                    color: AppColors.white,
                    size: AppSize.verylarge,
                    weight: FontWeight.w700,
                  ),
                  const Gap(12),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: height * 0.08,
                      width: width * 0.9,
                      child: ValueListenableBuilder(
                        valueListenable: widget.controller!,
                        builder: (context, value, child) {
                          return CustomTextField(
                            hintText: 'Search Events, Tickets, or City',
                            hintStyle: const TextStyle(color: AppColors.silver),
                            fillColor: AppColors.white,
                            controller: widget.controller!,
                            isFilled: true,
                            onChanged: (query) {
                              widget.setSearchQuery!(widget.controller!.text);
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
                                  child: widget.controller!.text.isEmpty
                                      ? const Icon(
                                          Icons.search,
                                          color: AppColors.white,
                                        )
                                      : InkWell(
                                          onTap: () {
                                            widget.controller!.clear();
                                            widget.setSearchQuery!(
                                                widget.controller!.text);
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
