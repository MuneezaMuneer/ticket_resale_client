// ignore_for_file: prefer_is_empty

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/db_services/firestore_services_client.dart';
import 'package:ticket_resale/models/tickets_sold_model.dart';
import 'package:ticket_resale/providers/bottom_sheet_provider.dart';
import 'package:ticket_resale/screens/screens.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomBottomSheet {
  static void showOTPBottomSheet(
      {required BuildContext context,
      required OnChanged onChanged,
      required String email,
      required String btnText,
      required OnTape onTape}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
                color: AppColors.paleGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Verification Code",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const Gap(10),
                Text(
                  "Verification code has been sent on\n $email. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 15),
                ),
                const SizedBox(
                  height: 20,
                ),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: AppColors.jetBlack,
                  focusedBorderColor: AppColors.jetBlack,
                  showFieldAsBox: true,
                  borderWidth: 4.0,
                  onSubmit: onChanged,
                ),
                const Gap(50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Consumer<BottomSheetProvider>(
                    builder: (context, loadingProvider, child) => SizedBox(
                      height: 60,
                      child: CustomButton(
                        loading: loadingProvider.getLoadingProgress,
                        gradient: customGradient,
                        btnText: btnText,
                        textColor: AppColors.white,
                        textSize: AppSize.regular,
                        weight: FontWeight.w500,
                        onPressed: onTape,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      backgroundColor: Colors.transparent,
      context: context,
    );
  }

  static showInstaBottomSheet({
    required BuildContext context,
    required TextEditingController controller,
    required OnTape onTape,
    required GlobalKey<FormState> defaultFormKey,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                  color: AppColors.paleGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Form(
                key: defaultFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      CustomTextField(
                        controller: controller,
                        hintStyle: const TextStyle(color: AppColors.silver),
                        hintText: 'Instagram @',
                        keyBoardType: TextInputType.emailAddress,
                        validator: (url) {
                          if (url!.isEmpty) {
                            return 'Please enter valid instagram';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Gap(50),
                      Consumer<BottomSheetProvider>(
                        builder: (context, instaProgress, child) =>
                            CustomButton(
                          loading: instaProgress.getInstaProgress,
                          fixedWidth: 200,
                          gradient: customGradient,
                          textColor: AppColors.white,
                          textSize: AppSize.regular,
                          weight: FontWeight.w500,
                          btnText: 'Save',
                          onPressed: onTape,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  static void showConfirmTicketsSheet(
      {required BuildContext context,
      required String hashKey,
      required String token,
      required var id,
      required String userId
      }) {
    List<TicketsSoldModel> selectedTickets = [];
    ValueNotifier<double> totalPriceNotifier = ValueNotifier<double>(0);

    void updateTotalPrice() {
      double totalPrice = 0;
      for (var ticket in selectedTickets) {
        totalPrice += double.parse(ticket.ticketPrice!);
      }
      totalPriceNotifier.value = totalPrice;
    }

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StreamBuilder<List<TicketsSoldModel>>(
            stream:
                FireStoreServicesClient.fetchSoldTicketsData(hashKey: hashKey),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!;
                return ValueListenableBuilder(
                  valueListenable: totalPriceNotifier,
                  builder: (context, totalPrice, child) {
                    return DefaultTabController(
                      length: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TabBar(tabs: [
                            Tab(
                              text: 'UnPaid',
                            ),
                            Tab(
                              text: 'Paid',
                            )
                          ]),
                          SizedBox(
                            height: 400,
                            child: TabBarView(
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: data
                                                    .where((ticket) =>
                                                        ticket.status ==
                                                        'Unpaid')
                                                    .length >
                                                0
                                            ? ListView.builder(
                                                itemCount: data
                                                    .where((ticket) =>
                                                        ticket.status ==
                                                        'Unpaid')
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final List<TicketsSoldModel>
                                                      paidTickets = data
                                                          .where((ticket) =>
                                                              ticket.status ==
                                                              'Unpaid')
                                                          .toList();
                                                  final ticket =
                                                      paidTickets[index];

                                                  bool isSelected =
                                                      selectedTickets
                                                          .contains(ticket);
                                                  return Column(
                                                    children: [
                                                      AuthServices.getCurrentUser
                                                                  .uid !=
                                                              id['seller_uid']
                                                          ? CheckboxListTile(
                                                              value: isSelected,
                                                              onChanged:
                                                                  (value) {
                                                                if (!selectedTickets
                                                                    .contains(
                                                                        ticket)) {
                                                                  selectedTickets
                                                                      .add(
                                                                          ticket);
                                                                  updateTotalPrice();
                                                                } else {
                                                                  selectedTickets
                                                                      .remove(
                                                                          ticket);
                                                                  updateTotalPrice();
                                                                }
                                                              },
                                                              secondary:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        ticket
                                                                            .ticketImage!),
                                                              ),
                                                              title: Text(
                                                                  '${ticket.ticketName} TICKET AVAILABLE'),
                                                              subtitle: Text(
                                                                  '\$${ticket.ticketPrice}'),
                                                            )
                                                          : ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        ticket
                                                                            .ticketImage!),
                                                              ),
                                                              title: Text(
                                                                  '${ticket.ticketName} TICKET AVAILABLE'),
                                                              subtitle: Text(
                                                                  '\$${ticket.ticketPrice}'),
                                                            ),
                                                      Divider(
                                                        color: AppColors
                                                            .lightBlack
                                                            .withOpacity(0.3),
                                                      )
                                                    ],
                                                  );
                                                },
                                              )
                                            : const Center(
                                                child: CustomText(
                                                  title: 'No Ticket Unpaid',
                                                ),
                                              )),
                                    AuthServices.getCurrentUser.uid !=
                                            id['seller_uid']
                                        ? Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: data
                                                        .where((ticket) =>
                                                            ticket.status ==
                                                            'Unpaid')
                                                        .length >
                                                    0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        title:
                                                            'Total Price: $totalPrice',
                                                        color:
                                                            AppColors.jetBlack,
                                                        size: AppSize.regular,
                                                      ),
                                                      CustomButton(
                                                        fixedWidth: 70,
                                                        gradient:
                                                            customGradient,
                                                        textColor:
                                                            AppColors.white,
                                                        textSize:
                                                            AppSize.regular,
                                                        weight: FontWeight.w700,
                                                        btnText: 'Pay',
                                                        onPressed: () {
                                                          if (totalPrice > 0) {
                                                            List<
                                                                    Map<String,
                                                                        dynamic>>
                                                                items = [];

                                                            for (var ticket
                                                                in selectedTickets) {
                                                              items.add({
                                                                "name":
                                                                    '${ticket.ticketName} Ticket',
                                                                "quantity": '1',
                                                                "price": ticket
                                                                    .ticketPrice,
                                                                "currency":
                                                                    'USD'
                                                              });
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    PaymentScreen(
                                                                  docIds: selectedTickets
                                                                      .where((ticket) =>
                                                                          ticket
                                                                              .docId !=
                                                                          null)
                                                                      .map((ticket) =>
                                                                          ticket
                                                                              .docId!)
                                                                      .toList(),

                                                                  totalPrice:
                                                                      totalPrice
                                                                          .toString(),
                                                                  items: items,
                                                                  hashKey:
                                                                      hashKey,
                                                                  token: token,
                                                                  userId: userId,
                                                                  // onFinish:
                                                                  //     (paymentId) async {
                                                                  //   PaypalPaymentServices
                                                                  //       .fetchPaymentDetails(
                                                                  //           "$paymentId");
                                                                  //   final snackBar = SnackBar(
                                                                  //     content: const Text(
                                                                  //         "Payment done Successfully"),
                                                                  //     duration:
                                                                  //         const Duration(
                                                                  //             seconds: 5),
                                                                  //     action: SnackBarAction(
                                                                  //       label: 'Close',
                                                                  //       onPressed: () {
                                                                  //         Navigator.pop(
                                                                  //             context);
                                                                  //       },
                                                                  //     ),
                                                                  //   );
                                                                  //   ScaffoldMessenger.of(
                                                                  //           context)
                                                                  //       .showSnackBar(
                                                                  //           snackBar);
                                                                  // },
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox.shrink())
                                        : const SizedBox()
                                  ],
                                ),
                                data
                                            .where((ticket) =>
                                                ticket.status == 'Paid')
                                            .length >
                                        0
                                    ? ListView.builder(
                                        itemCount: data
                                            .where((ticket) =>
                                                ticket.status == 'Paid')
                                            .length,
                                        itemBuilder: (context, index) {
                                          final List<TicketsSoldModel>
                                              paidTickets = data
                                                  .where((ticket) =>
                                                      ticket.status == 'Paid')
                                                  .toList();
                                          final ticket = paidTickets[index];

                                          return Column(
                                            children: [
                                              ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      ticket.ticketImage!),
                                                ),
                                                title: Text(
                                                    '${ticket.ticketName} TICKET AVAILABLE'),
                                                subtitle: Text(
                                                    '\$${ticket.ticketPrice}'),
                                              ),
                                              Divider(
                                                color: AppColors.lightBlack
                                                    .withOpacity(0.3),
                                              )
                                            ],
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: CustomText(
                                        title: 'No Paid Ticket',
                                      )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Text('No Ticket Confirmed');
              }
            },
          ),
        );
      },
    );
  }
}
