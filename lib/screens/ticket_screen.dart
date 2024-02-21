import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/auth_services.dart';
import 'package:ticket_resale/db_services/firestore_services.dart';
import 'package:ticket_resale/models/event_modal.dart';
import 'package:ticket_resale/providers/image_picker_provider.dart';
import 'package:ticket_resale/utils/app_utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

TextEditingController festivalNameController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController ticketTypeController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
ValueNotifier<bool> notifier = ValueNotifier<bool>(false);
late ImagePickerProvider imagePickerProvider;

class _TicketScreenState extends State<TicketScreen> {
  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    super.initState();
  }

  bool validateImage() {
    return imagePickerProvider.getImageUrl.isNotEmpty &&
        File(imagePickerProvider.getImageUrl).existsSync();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Add New Ticket',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Consumer<ImagePickerProvider>(
                    builder: (context, value, child) {
                      return Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: AppColors.skyBlue, width: 1),
                          ),
                          child: imagePickerProvider.getImageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: width,
                                        child: Image.file(
                                          File(value.getImageUrl),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            String image = await AppUtils
                                                .getImageFromGallery();
                                            imagePickerProvider.setImageUrl =
                                                image;
                                            log('The Url is : ${imagePickerProvider.getImageUrl}');
                                          },
                                          child:
                                              SvgPicture.asset(AppSvgs.image)),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () async {
                                            String image = await AppUtils
                                                .getImageFromGallery();
                                            imagePickerProvider.setImageUrl =
                                                image;
                                            log('The Url is : ${imagePickerProvider.getImageUrl}');
                                          },
                                          child:
                                              SvgPicture.asset(AppSvgs.image)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const CustomText(
                                        title: 'Add Ticket Image Thumbnail',
                                        color: AppColors.silver,
                                        size: AppSize.medium,
                                        weight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                ));
                    },
                  ),
                  const Gap(10),
                  const CustomText(
                    title:
                        '* Proof of ticket ownership, can be screenshot or email.',
                    size: AppSize.small,
                    weight: FontWeight.w500,
                    softWrap: true,
                    color: AppColors.lightGrey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText(
                    title: 'Festival Name',
                    color: AppColors.gryishBlue,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    hintText: 'Festival Name',
                    weight: FontWeight.w400,
                    controller: festivalNameController,
                    hintStyle: _buildHintStyle(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter festival name';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    title: 'Date',
                    color: AppColors.gryishBlue,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: dateController,
                    hintText: 'Date',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          AppUtils.openDatePicker(context,
                              dateController: dateController);
                        },
                        child: SvgPicture.asset(
                          AppSvgs.date,
                        ),
                      ),
                    ),
                    hintStyle: _buildHintStyle(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' Enter Date';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    title: 'Ticket Type',
                    color: AppColors.gryishBlue,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    hintText: 'Select Type',
                    controller: ticketTypeController,
                    isSuffixIcon: true,
                    suffixIcon: DropDownWidget(
                      itemList: const ['VIP', 'Basic', 'Professional'],
                      icon: Icons.keyboard_arrow_down_rounded,
                      controller: ticketTypeController,
                      onChanged: (String? selectOption) {
                        ticketTypeController.text = '$selectOption';
                      },
                    ),
                    hintStyle: _buildHintStyle(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Ticket type';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    title: 'Set Price',
                    color: AppColors.gryishBlue,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    hintText: 'Enter Ticket Price',
                    controller: priceController,
                    hintStyle: _buildHintStyle(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    title: 'Description',
                    color: AppColors.gryishBlue,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    maxLines: 5,
                    isCommentField: true,
                    hintText: 'Enter your description here.',
                    hintStyle: _buildHintStyle(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  ValueListenableBuilder(
                    valueListenable: notifier,
                    builder: (context, value, child) {
                      return CustomButton(
                        backgroundColor: AppColors.white,
                        btnText: 'Submit',
                        weight: FontWeight.w700,
                        loading: notifier.value,
                        textColor: AppColors.white,
                        gradient: customGradient,
                        textSize: AppSize.regular,
                        onPressed: () async {
                          if (formKey.currentState!.validate() &&
                              validateImage()) {
                            notifier.value = true;
                            String? imageUrl =
                                await AuthServices.uploadEventImage(
                                    imagePath: imagePickerProvider.getImageUrl);
                            EventModal eventModal = EventModal(
                                imageUrl: imageUrl,
                                festivalName: festivalNameController.text,
                                ticketType: ticketTypeController.text,
                                date: dateController.text,
                                price: priceController.text,
                                description: descriptionController.text,
                                userId: AuthServices.getCurrentUser.uid);

                            if (imageUrl != null && imageUrl != '') {
                              await FireStoreServices.uploadEventData(
                                  eventModal: eventModal);
                              notifier.value = false;
                            }
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  TextStyle _buildHintStyle() {
    return const TextStyle(
        color: AppColors.silver,
        fontWeight: FontWeight.w400,
        fontSize: AppSize.medium);
  }
}
