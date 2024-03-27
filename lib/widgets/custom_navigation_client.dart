import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/screens/screens.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomNavigationClient extends StatefulWidget {
  const CustomNavigationClient({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomNavigationClientState createState() => _CustomNavigationClientState();
}

class _CustomNavigationClientState extends State<CustomNavigationClient> {
  late NavigationProvider navigationProvider;

  @override
  void initState() {
    super.initState();
    NotificationServices.getFCMCurrentDeviceToken().then((token) {
      AuthServices.storeFCMToken(fcmToken: '$token');
    });

    NotificationServices.requestPermission().then((granted) {
      if (granted) {
        NotificationServices.forGroundNotifications(context);
        NotificationServices.appOpenInBackground(context: context);
      }
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        NotificationServices.handleNotificationResponse(context, message);
      }
    });
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
                                AppSvgs.home,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.blueViolet, BlendMode.srcIn),
                              ),
                              const CustomText(
                                title: 'Home',
                                color: AppColors.blueViolet,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SvgPicture.asset(AppSvgs.home,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.blueViolet.withOpacity(0.6),
                                      BlendMode.srcIn)),
                              CustomText(
                                title: 'Home',
                                color: AppColors.blueViolet.withOpacity(0.6),
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
                                AppSvgs.event,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.blueViolet, BlendMode.srcIn),
                              ),
                              const CustomText(
                                title: 'Events',
                                color: AppColors.blueViolet,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SvgPicture.asset(AppSvgs.event,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.blueViolet.withOpacity(0.6),
                                      BlendMode.srcIn)),
                              CustomText(
                                title: 'Events',
                                color: AppColors.blueViolet.withOpacity(0.6),
                              )
                            ],
                          )),
                IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      navigationProvider.setSelectedIndex(2);
                    },
                    icon: Stack(
                      children: [
                        SvgPicture.asset(
                          AppSvgs.plus,
                          colorFilter: const ColorFilter.mode(
                              AppColors.blueViolet, BlendMode.srcIn),
                        ),
                        const Positioned(
                          left: 0,
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                        ),
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
                              AppSvgs.level,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.blueViolet, BlendMode.srcIn),
                            ),
                            const CustomText(
                              title: 'Levels',
                              color: AppColors.blueViolet,
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SvgPicture.asset(AppSvgs.level,
                                colorFilter: ColorFilter.mode(
                                    AppColors.blueViolet.withOpacity(0.6),
                                    BlendMode.srcIn)),
                            CustomText(
                              title: 'Levels',
                              color: AppColors.blueViolet.withOpacity(0.6),
                            )
                          ],
                        ),
                ),
                IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      navigationProvider.setSelectedIndex(4);
                    },
                    icon: indexValue.selectedIndex == 4
                        ? Column(
                            children: [
                              SvgPicture.asset(
                                AppSvgs.profile,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.blueViolet, BlendMode.srcIn),
                              ),
                              const CustomText(
                                title: 'Profile',
                                color: AppColors.blueViolet,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SvgPicture.asset(AppSvgs.profile,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.blueViolet.withOpacity(0.6),
                                      BlendMode.srcIn)),
                              CustomText(
                                title: 'Profile',
                                color: AppColors.blueViolet.withOpacity(0.6),
                              )
                            ],
                          )),
              ],
            ),
          ),
        );
      },
    );
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const EventScreen(isBackButton: false),
    const TicketScreen(),
    ProfileLevelScreen(isBackButton: false),
    const ProfileScreen(),
  ];
}
