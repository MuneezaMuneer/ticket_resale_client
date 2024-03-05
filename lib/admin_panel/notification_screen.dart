import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/admin_panel/custom_appbar.dart';
import '../constants/constants.dart';
import '../providers/search_provider.dart';
import '../widgets/widgets.dart';
class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});
  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}
class _AdminNotificationState extends State<AdminNotification> {
  ValueNotifier<String> searchNotifier = ValueNotifier('');
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Consumer<SearchProvider>(
        builder: (context, searchprovider, child) => Scaffold(
              appBar: searchprovider.isSearching
                  ? PreferredSize(
                      preferredSize: Size.fromHeight(60),
                      child: CustomAppBarField(
                          searchController: searchcontroller,
                          setSearchValue: (searchQuery) {
                            searchNotifier.value = searchQuery;
                          }))
                  : const PreferredSize(
                      preferredSize: Size.fromHeight(60),
                      child: CustomAppBarAdmin()),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CustomText(
                      title: 'Recent Notifications',
                      weight: FontWeight.w600,
                      size: AppSize.regular,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: height * 0.85,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: notificationtiles(),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  Widget notificationtiles() {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Container(
      width: width,
      height: height * 0.15,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.blueViolet,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:
                        Center(child: SvgPicture.asset(AppSvgs.notification)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width,
                        child: RichText(
                          text: TextSpan(
                            text: 'Ticket listing request!  ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: AppSize.medium,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    ' John Doe send a request to list a ticket in event name',
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: AppSize.medium,
                                  fontWeight: FontWeight.w300,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(5),
                      const CustomText(
                        title: '(Today at 9:34 PM)',
                        weight: FontWeight.w400,
                        size: AppSize.small,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.midNight,
                  ),
                  child: const Center(
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: AppSize.small,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
