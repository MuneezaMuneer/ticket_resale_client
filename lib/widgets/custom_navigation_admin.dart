import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/screens/admin_screen/admin_screen.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomNavigationAdmin extends StatefulWidget {
  const CustomNavigationAdmin({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CustomNavigationAdminState createState() => _CustomNavigationAdminState();
}

class _CustomNavigationAdminState extends State<CustomNavigationAdmin> {
  late NavigationProvider navigationProvider;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      navigationProvider =
          Provider.of<NavigationProvider>(context, listen: false);
      navigationProvider.setSelectedIndex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, indexValue, child) {
        return Scaffold(
          body: _widgetOptions[indexValue.selectedIndex],
          bottomNavigationBar: Container(
            height: 75,
            decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
              BoxShadow(color: AppColors.purple, blurRadius: 10)
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        navigationProvider.setSelectedIndex(0);
                      },
                      icon: indexValue.selectedIndex == 0
                          ? Column(
                              children: [
                                SvgPicture.asset(
                                  AppSvgs.ticketListing,
                                  height: 20,
                                  width: 20,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.blueViolet, BlendMode.srcIn),
                                ),
                                const CustomText(
                                  title: 'Event Management',
                                  size: AppSize.xxsmall,
                                  color: AppColors.blueViolet,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                SvgPicture.asset(AppSvgs.ticketListing,
                                    height: 20,
                                    width: 20,
                                    colorFilter: ColorFilter.mode(
                                        AppColors.blueViolet.withOpacity(0.4),
                                        BlendMode.srcIn)),
                                CustomText(
                                  title: 'Event Management',
                                  size: AppSize.xxsmall,
                                  color: AppColors.blueViolet.withOpacity(0.4),
                                )
                              ],
                            )),
                  IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        navigationProvider.setSelectedIndex(1);
                      },
                      icon: indexValue.selectedIndex == 1
                          ? Column(
                              children: [
                                SvgPicture.asset(
                                  AppSvgs.ticketListing,
                                  height: 20,
                                  width: 20,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.blueViolet, BlendMode.srcIn),
                                ),
                                const CustomText(
                                  title: 'Ticket Listing',
                                  size: AppSize.xxsmall,
                                  color: AppColors.blueViolet,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                SvgPicture.asset(AppSvgs.ticketListing,
                                    height: 20,
                                    width: 20,
                                    colorFilter: ColorFilter.mode(
                                        AppColors.blueViolet.withOpacity(0.4),
                                        BlendMode.srcIn)),
                                CustomText(
                                  title: 'Ticket Listing',
                                  size: AppSize.xxsmall,
                                  color: AppColors.blueViolet.withOpacity(0.4),
                                )
                              ],
                            )),
                  IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        navigationProvider.setSelectedIndex(2);
                      },
                      icon: indexValue.selectedIndex == 2
                          ? Column(
                              children: [
                                SvgPicture.asset(
                                  height: 20,
                                  width: 20,
                                  AppSvgs.userManagement,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.blueViolet, BlendMode.srcIn),
                                ),
                                const CustomText(
                                  title: 'User Management',
                                  color: AppColors.blueViolet,
                                  size: AppSize.xxsmall,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                SvgPicture.asset(AppSvgs.userManagement,
                                    height: 20,
                                    width: 20,
                                    colorFilter: ColorFilter.mode(
                                        AppColors.blueViolet.withOpacity(0.4),
                                        BlendMode.srcIn)),
                                CustomText(
                                  title: 'User Management',
                                  size: AppSize.xxsmall,
                                  color: AppColors.blueViolet.withOpacity(0.4),
                                )
                              ],
                            )),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      navigationProvider.setSelectedIndex(3);
                    },
                    icon: indexValue.selectedIndex == 3
                        ? Column(
                            children: [
                              SvgPicture.asset(
                                AppSvgs.notifications,
                                height: 20,
                                width: 20,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.blueViolet, BlendMode.srcIn),
                              ),
                              const CustomText(
                                title: 'Notification',
                                size: AppSize.xxsmall,
                                color: AppColors.blueViolet,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SvgPicture.asset(AppSvgs.notifications,
                                  height: 20,
                                  width: 20,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.blueViolet.withOpacity(0.4),
                                      BlendMode.srcIn)),
                              CustomText(
                                title: 'Notification',
                                size: AppSize.xxsmall,
                                color: AppColors.blueViolet.withOpacity(0.4),
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const EventListing(),
    const TicketListing(),
    const UserManagement(),
    const AdminNotification(),
  ];
}
