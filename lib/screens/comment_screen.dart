// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';

import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/auth_services.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CommentScreen extends StatefulWidget {
  String id;
  CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    Provider.of<SwitchProvider>(context, listen: false).loadPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      body: AppBackground(
        imagePath: AppImages.concert,
        isBackButton: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 28, right: 28, top: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      title: 'Comments',
                      size: AppSize.regular,
                      color: AppColors.jetBlack,
                      weight: FontWeight.w600,
                    ),
                    Row(
                      children: [
                        const CustomText(
                          title: 'Subcribe to comments',
                          size: AppSize.medium,
                          weight: FontWeight.w400,
                          color: AppColors.lightGrey,
                        ),
                        Consumer<SwitchProvider>(
                          builder: (context, provider, child) {
                            return Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                activeColor: AppColors.blueViolet,
                                thumbColor: Colors.white,
                                trackColor: AppColors.pastelBlue,
                                value: provider.getComment,
                                onChanged: (bool value) {
                                  provider.setComment(value);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                    height: height * 0.4,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 6),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        bool isCurrentUserTicket =
                            AuthServices.getCurrentUser.uid == widget.id;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(AppImages.profile),
                              ),
                              const Gap(20),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CustomText(
                                          title: 'Lucy Lure',
                                          size: AppSize.intermediate,
                                          weight: FontWeight.w600,
                                          color: AppColors.jetBlack,
                                        ),
                                        const Gap(15),
                                        Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: AppColors.lightGrey
                                                  .withOpacity(0.7),
                                              shape: BoxShape.circle),
                                        ),
                                        const Gap(5),
                                        CustomText(
                                          title: '2 mintues ago',
                                          size: AppSize.medium,
                                          weight: FontWeight.w400,
                                          color: AppColors.lightGrey
                                              .withOpacity(0.7),
                                        ),
                                      ],
                                    ),
                                    const CustomText(
                                      title:
                                          'Sed ut est eget dolor finibus the way is',
                                      size: AppSize.intermediate,
                                      weight: FontWeight.w400,
                                      color: AppColors.lightGrey,
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                    const Gap(5),
                                    RichText(
                                        text: const TextSpan(children: [
                                      TextSpan(
                                          text: 'Offered Price is',
                                          style: TextStyle(
                                              letterSpacing: 0.5,
                                              color: AppColors.lightGrey,
                                              fontSize: AppSize.small,
                                              fontWeight: FontWeight.w400)),
                                      WidgetSpan(
                                        child: SizedBox(width: 5.0),
                                      ),
                                      TextSpan(
                                          text: '\$420',
                                          style: TextStyle(
                                              letterSpacing: 0.5,
                                              color: AppColors.lightBlack,
                                              fontSize: AppSize.small,
                                              fontWeight: FontWeight.w600))
                                    ]))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                    height: height * 0.04,
                                    width: width * 0.15,
                                    child: isCurrentUserTicket
                                        ? CustomButton(
                                            onPressed: () {
                                              ticketSellDialog(
                                                  context: context);
                                            },
                                            textColor: AppColors.white,
                                            textSize: AppSize.medium,
                                            btnText: 'Sell',
                                            gradient: customGradient,
                                            weight: FontWeight.w600,
                                          )
                                        : const SizedBox.shrink()),
                              )
                            ],
                          ),
                        );
                      },
                    )),
                const Gap(15),
                SizedBox(
                  height: height * 0.07,
                  width: width * 0.9,
                  child: CustomTextField(
                    hintText: 'Enter your comment here',
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
                        child: Center(child: SvgPicture.asset(AppSvgs.send)),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.lightGrey),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    const Gap(10),
                    const CustomText(
                      title: 'I need help (Alert Rave Trade Staff)',
                      color: AppColors.lightGrey,
                      weight: FontWeight.w400,
                      size: AppSize.medium,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
