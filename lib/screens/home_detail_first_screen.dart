// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/app_utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../components/components.dart';

class HomeDetailFirstScreen extends StatefulWidget {
  EventModal eventModal;
  HomeDetailFirstScreen({
    Key? key,
    required this.eventModal,
  }) : super(key: key);

  @override
  State<HomeDetailFirstScreen> createState() => _HomeDetailFirstScreenState();
}

class _HomeDetailFirstScreenState extends State<HomeDetailFirstScreen> {
  late Stream<List<TicketModel>> displayTickets;
  String photoURL = '';
  @override
  void initState() {
    displayTickets =
        FireStoreServices.fetchTicketsData(docID: widget.eventModal.docId!);
    photoURL = '${AuthServices.getCurrentUser.photoURL}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Model id is : ${widget.eventModal.docId}');
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      body: AppBackground(
        networkImage: widget.eventModal.imageUrl,
        isAssetImage: false,
        isBackButton: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 23, top: 20, right: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: widget.eventModal.festivalName,
                          size: AppSize.large,
                          weight: FontWeight.w600,
                          softWrap: true,
                          color: AppColors.jetBlack,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SvgPicture.asset(
                        AppSvgs.share,
                        alignment: Alignment.centerRight,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  const Gap(10),
                  Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56),
                        border: Border.all(color: AppColors.white),
                        color: AppColors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColors.paleGrey,
                                radius: 17,
                                backgroundImage:
                                    AssetImage(AppImages.profileImage),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                ),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Featured DJ : ',
                                      style: TextStyle(
                                          color: AppColors.lightGrey
                                              .withOpacity(0.6),
                                          fontSize: AppSize.xsmall,
                                          fontWeight: FontWeight.w400)),
                                  const TextSpan(
                                      text: 'Martin Garrix',
                                      style: TextStyle(
                                          color: AppColors.blueViolet,
                                          fontSize: AppSize.medium,
                                          fontWeight: FontWeight.w600)),
                                ])),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(15),
                  Container(
                    height: height * 0.08,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56),
                        border: Border.all(color: AppColors.white),
                        color: AppColors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  backgroundColor: AppColors.paleGrey,
                                  radius: 20,
                                  child: SvgPicture.asset(
                                    AppSvgs.clock,
                                    height: 30,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title:
                                          '${AppUtils.formatDate(widget.eventModal.date!)}, ${widget.eventModal.time}',
                                      color:
                                          AppColors.lightGrey.withOpacity(0.6),
                                      size: AppSize.xsmall,
                                      weight: FontWeight.w400,
                                    ),
                                    const Gap(2),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'at ',
                                          style: TextStyle(
                                              color: AppColors.lightGrey
                                                  .withOpacity(0.6),
                                              letterSpacing: 0.8,
                                              fontSize: AppSize.xsmall,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: '${widget.eventModal.city}',
                                          style: const TextStyle(
                                              color: AppColors.jetBlack,
                                              letterSpacing: 0.8,
                                              fontSize: AppSize.small,
                                              fontWeight: FontWeight.w600)),
                                    ])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  const CustomText(
                    title: 'About Event',
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                    color: AppColors.jetBlack,
                  ),
                  CustomText(
                    title: '${widget.eventModal.description}',
                    size: AppSize.medium,
                    softWrap: true,
                    weight: FontWeight.w400,
                    color: AppColors.lightGrey,
                  ),
                  const Gap(20),
                  const CustomText(
                    title: 'Tickets Available by Sellers',
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                    color: AppColors.jetBlack,
                  ),
                  const Gap(15),
                  StreamBuilder(
                    stream: displayTickets,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (snapshot.hasData && snapshot.data != null) {
                        final tickets = snapshot.data!;
                        if (tickets.isNotEmpty) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tickets.length,
                            itemExtent: 140,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: InkWell(
                                  onTap: () {
                                    TicketModel ticketModel = TicketModel(
                                      imageUrl: photoURL,
                                      ticketType: tickets[index].ticketType,
                                      description: tickets[index].description,
                                      status: tickets[index].status,
                                      price: tickets[index].price,
                                      uid: tickets[index].uid,
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.detailSecondScreen,
                                      arguments: {
                                        'eventModal': widget.eventModal,
                                        'ticketModel': ticketModel,
                                      },
                                    );
                                  },
                                  child: _tileContainer(
                                      title:
                                          '${tickets[index].ticketType} TICKET AVAILABLE',
                                      subTitle:
                                          'VIP Seats + Exclusive braclets',
                                      price: '${tickets[index].price}',
                                      imagePath: '${tickets[index].imageUrl}',
                                      userImage: photoURL),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: Column(
                            children: [
                              Gap(30),
                              Text('No Ticket Available'),
                            ],
                          ));
                        }
                      } else {
                        return const Text('No Ticket Available');
                      }
                    },
                  ),
                  const Gap(10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tileContainer({
    String? title,
    String? subTitle,
    String? price,
    String? imagePath,
    String? userImage,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blueViolet)),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0XffF7F5FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            radius: 20,
                            backgroundImage: NetworkImage('$imagePath'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: '$title',
                                color: AppColors.jetBlack,
                                size: AppSize.small,
                                weight: FontWeight.w600,
                              ),
                              CustomText(
                                title: '$subTitle',
                                color: AppColors.lightGrey.withOpacity(0.6),
                                size: AppSize.xsmall,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: CustomText(
                      title: '\$ $price',
                      color: const Color(0XffAC8AF7),
                      size: 18,
                      weight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              userImage != null && userImage != 'null'
                                  ? NetworkImage(userImage)
                                  : const AssetImage(AppImages.profileImage)
                                      as ImageProvider,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: 'Sell by',
                                color: AppColors.lightBlack.withOpacity(0.7),
                                size: AppSize.verySmall,
                                weight: FontWeight.w300,
                              ),
                              CustomText(
                                title:
                                    '${AuthServices.getCurrentUser.displayName}',
                                color: AppColors.lightBlack.withOpacity(0.6),
                                size: AppSize.intermediate,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset(AppSvgs.levelFour))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
