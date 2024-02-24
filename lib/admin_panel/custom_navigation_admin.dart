import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/admin_panel/notification_screen.dart';
import 'package:ticket_resale/admin_panel/ticket_listing_screen.dart';
import 'package:ticket_resale/admin_panel/user_management.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/providers/navigation_provider.dart';
import 'package:ticket_resale/widgets/custom_text.dart';

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
            height: 70,
            decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
              BoxShadow(color: AppColors.purple, blurRadius: 10)
            ]),
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
                                colorFilter: const ColorFilter.mode(
                                    AppColors.blueViolet, BlendMode.srcIn),
                              ),
                              const CustomText(
                                title: 'Ticket Listing',
                                color: AppColors.blueViolet,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SvgPicture.asset(AppSvgs.ticketListing,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.blueViolet.withOpacity(0.4),
                                      BlendMode.srcIn)),
                              CustomText(
                                title: 'Ticket Listing',
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
                                colorFilter: const ColorFilter.mode(
                                    AppColors.blueViolet, BlendMode.srcIn),
                              ),
                              const CustomText(
                                title: 'User Management',
                                color: AppColors.blueViolet,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SvgPicture.asset(AppSvgs.ticketListing,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.blueViolet.withOpacity(0.4),
                                      BlendMode.srcIn)),
                              CustomText(
                                title: 'User Management',
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
                              AppSvgs.ticketListing,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.blueViolet, BlendMode.srcIn),
                            ),
                            const CustomText(
                              title: 'Notification',
                              color: AppColors.blueViolet,
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SvgPicture.asset(AppSvgs.ticketListing,
                                colorFilter: ColorFilter.mode(
                                    AppColors.blueViolet.withOpacity(0.4),
                                    BlendMode.srcIn)),
                            CustomText(
                              title: 'Notification',
                              color: AppColors.blueViolet.withOpacity(0.4),
                            )
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const TicketListing(),
    const UserManagement(),
    const AdminNotification(),
  ];
}
