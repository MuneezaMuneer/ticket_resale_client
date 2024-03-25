import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/widgets/custom_gradient.dart';
import 'package:ticket_resale/widgets/custom_text.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../components/components.dart';
import '../constants/constants.dart';
import '../providers/search_provider.dart';
import 'custom_text_field.dart';

class CustomAppBarClient extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Widget? child;
  final bool isNotification;
  final bool isBackButton;
  final bool isOpenedFromDialog;
  final bool isNetworkImage;
  final String? networkImage;
  const CustomAppBarClient(
      {super.key,
      this.title,
      this.child,
      this.isNotification = true,
      this.isBackButton = true,
      this.isNetworkImage = false,
      this.networkImage,
      this.isOpenedFromDialog = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Container(
      height: height * 0.13,
      width: width,
      decoration: BoxDecoration(
          gradient: customGradient,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        if (isOpenedFromDialog == true) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutes.navigationScreen, (route) => false);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: isBackButton
                          ? const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                              size: 18,
                            )
                          : const SizedBox.shrink()),
                  SizedBox(
                      child: isNetworkImage
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8, left: 10),
                              child: SizedBox(
                                  child: (networkImage != null) &&
                                          networkImage != 'null'
                                      ? CustomDisplayStoryImage(
                                          imageUrl: '$networkImage',
                                          height: 43,
                                          width: 43,
                                        )
                                      : const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              AppImages.profileImage))),
                            )
                          : const SizedBox.shrink()),
                  const Gap(15),
                  CustomText(
                    title: '$title',
                    weight: FontWeight.w600,
                    size: AppSize.regular,
                    color: AppColors.white,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: SizedBox(
                  child: isNotification
                      ? InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.notificationScreen);
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
                              )))
                      : const SizedBox.shrink()),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? child;
  final bool isNotification;
  final bool isSearchIcon;

  const CustomAppBarAdmin({
    super.key,
    this.title,
    this.child,
    this.isSearchIcon = true,
    this.isNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final searchProvider = Provider.of<SearchProvider>(context);
    return Container(
      height: height * 0.13,
      width: width,
      decoration: BoxDecoration(
          gradient: customGradient,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Gap(10),
                  CustomText(
                    title: 'Admin Panel',
                    weight: FontWeight.w600,
                    size: AppSize.regular,
                    color: AppColors.white,
                  )
                ],
              ),
            ),
            SizedBox(
              width: width * 0.2,
            ),
            if (isSearchIcon)
              GestureDetector(
                onTap: () {
                  searchProvider.toggleSearch();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white.withOpacity(0.1),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.search,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    AppText.preference!.remove(AppText.isAdminPrefKey);

                    return Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.logoutAdmin, (route) => false);
                  });
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
                    child: SvgPicture.asset(AppSvgs.logout),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarField extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController? searchController;
  final SearchCallbackFunc? setSearchValue;
  final String? text;

  const CustomAppBarField(
      {Key? key,
      this.searchController,
      this.setSearchValue,
      required this.text})
      : super(key: key);

  @override
  State<CustomAppBarField> createState() => _CustomAppBarFieldState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _CustomAppBarFieldState extends State<CustomAppBarField> {
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return AppBar(
        leading: GestureDetector(
            onTap: () {
              searchProvider.toggleSearch();
            },
            child: const Icon(Icons.arrow_back)),
        title: ValueListenableBuilder(
          valueListenable: widget.searchController!,
          builder: (context, value, child) => CustomTextField(
            controller: widget.searchController,
            onChanged: (query) {
              widget.setSearchValue!(widget.searchController!.text);
            },
            fillColor: AppColors.white,
            hintText: widget.text,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppSize.medium,
              color: AppColors.grey,
            ),
            suffixIcon: widget.searchController!.text.isEmpty
                ? const Icon(Icons.search)
                : GestureDetector(
                    onTap: () {
                      widget.searchController!.clear();
                      widget.setSearchValue!(widget.searchController!.text);
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppColors.grey,
                    ),
                  ),
          ),
        ));
  }

  Size get preferredSize => const Size.fromHeight(60);
}
