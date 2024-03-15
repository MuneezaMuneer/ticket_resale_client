import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:ticket_resale/admin_panel/custom_appbar.dart';
import 'package:ticket_resale/admin_panel/snackbar.dart';
import 'package:ticket_resale/providers/event_image_provider.dart';
import 'package:uuid/uuid.dart';
import '../constants/constants.dart';
import '../db_services/db_services.dart';
import '../models/create_event.dart';

import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'firestore_services.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});
  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController festivalNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String startTime;
  late String endTime;
  late EventImagePickerProvider imagePickerProvider;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    imagePickerProvider =
        Provider.of<EventImagePickerProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      imagePickerProvider.clear();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    festivalNameController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    locationController.dispose();
    endTimeController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBarAdmin(
              isSearchIcon: false,
            )),
        body: Center(
          child: SizedBox(
            width: width * 0.85,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(15),
                          const CustomText(
                            title: 'Add Event',
                            weight: FontWeight.w600,
                            size: AppSize.regular,
                          ),
                          const Gap(15),
                          Align(
                            alignment: Alignment.center,
                            child: Consumer<EventImagePickerProvider>(
                              builder: (context, value, child) => Container(
                                height: height * 0.2,
                                width: width * 0.85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: AppColors.pastelBlue)),
                                child: imagePickerProvider
                                        .getImageBytes.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                              width: width,
                                              child: Image.memory(
                                                value.getImageBytes,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                AuthServices
                                                        .getImageFromGallery(
                                                            context: context)
                                                    .then((image) async {
                                                  imagePickerProvider
                                                      .setImageBytes = image;
                                                });
                                              },
                                              child: const Icon(
                                                Icons.add_a_photo_outlined,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              AuthServices.getImageFromGallery(
                                                      context: context)
                                                  .then((image) async {
                                                imagePickerProvider
                                                    .setImageBytes = image;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.add_a_photo_outlined,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const CustomText(
                                            title: 'Add Event Image Thumbnail',
                                            color: AppColors.jetBlack,
                                            size: AppSize.medium,
                                            weight: FontWeight.w500,
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          const Gap(15),
                          const CustomText(
                            title: 'Event Name',
                            color: AppColors.jetBlack,
                            weight: FontWeight.w600,
                            size: AppSize.medium,
                          ),
                          const Gap(10),
                          CustomTextField(
                            hintText: 'Event Name',
                            weight: FontWeight.w400,
                            controller: festivalNameController,
                            hintStyle: _buildHintStyle(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Event name';
                              }

                              return null;
                            },
                          ),
                          const Gap(15),
                          const CustomText(
                            title: 'Date',
                            color: AppColors.jetBlack,
                            weight: FontWeight.w600,
                            size: AppSize.medium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Gap(10),
                          CustomTextField(
                            controller: dateController,
                            hintText: 'Date',
                            readOnly: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                  onTap: () {
                                    AppUtils.openDatePicker(context,
                                        dateController: dateController);
                                  },
                                  child: const Icon(
                                    Icons.date_range_outlined,
                                    color: AppColors.lightGrey,
                                  )),
                            ),
                            hintStyle: _buildHintStyle(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' Enter Date';
                              }

                              return null;
                            },
                          ),
                          const Gap(15),
                          const Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  title: 'Start Time',
                                  color: AppColors.jetBlack,
                                  weight: FontWeight.w600,
                                  size: AppSize.medium,
                                ),
                              ),
                              Expanded(
                                child: CustomText(
                                  title: 'End Time',
                                  color: AppColors.jetBlack,
                                  weight: FontWeight.w600,
                                  size: AppSize.medium,
                                ),
                              ),
                            ],
                          ),
                          const Gap(15),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: startTimeController,
                                  readOnly: true,
                                  hintText: 'Start Time',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: GestureDetector(
                                        onTap: () async {
                                          TimeOfDay? time =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now());
                                          if (time != null) {
                                            startTimeController.text =
                                                time.format(context);
                                            startTime =
                                                startTimeController.text;
                                          }
                                        },
                                        child: const Icon(
                                          Icons.alarm,
                                          color: AppColors.lightGrey,
                                        )),
                                  ),
                                  hintStyle: _buildHintStyle(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter valid time';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              const Gap(15),
                              Expanded(
                                child: CustomTextField(
                                  controller: endTimeController,
                                  readOnly: true,
                                  hintText: 'End Time',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: GestureDetector(
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );

                                        if (pickedTime != null) {
                                          endTimeController.text =
                                              pickedTime.format(context);

                                          endTime = endTimeController.text;
                                        }
                                      },
                                      child: const Icon(
                                        Icons.alarm,
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                  ),
                                  hintStyle: _buildHintStyle(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter valid time';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(15),
                          const CustomText(
                            title: 'Location',
                            color: AppColors.jetBlack,
                            weight: FontWeight.w600,
                            size: AppSize.medium,
                          ),
                          const Gap(10),
                          CustomTextField(
                            hintText: 'Location',
                            weight: FontWeight.w400,
                            controller: locationController,
                            hintStyle: _buildHintStyle(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your location';
                              }

                              return null;
                            },
                          ),
                          const Gap(10),
                          const CustomText(
                            title: 'Description',
                            color: AppColors.jetBlack,
                            weight: FontWeight.w600,
                            size: AppSize.medium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Gap(15),
                          CustomTextField(
                            controller: descriptionController,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<EventImagePickerProvider>(
                            builder: (context, imagePickerProvider, child) =>
                                ValueListenableBuilder(
                              valueListenable: isLoading,
                              builder: (context, value, child) {
                                return CustomButton(
                                  btnText: 'Create',
                                  loading: value,
                                  weight: FontWeight.w700,
                                  textColor: AppColors.white,
                                  gradient: customGradient,
                                  textSize: AppSize.regular,
                                  onPressed: () async {
                                    Uuid uuid = const Uuid();
                                    String uv4 = uuid.v4();

                                    if (formKey.currentState!.validate()) {
                                      isLoading.value = true;

                                      if (imagePickerProvider
                                          .getImageBytes.isEmpty) {
                                        AppUtils.toastMessage(
                                            'Please Select Image');
                                        return;
                                      }
                                      imagePickerProvider.setImageUrl =
                                          await AuthServices
                                              .storeImageToFirebase(
                                                  context: context,
                                                  image: imagePickerProvider
                                                      .getImageBytes);

                                      try {
                                        isLoading.value = true;

                                        CreateEvents createEvents =
                                            CreateEvents(
                                          imageUrl:
                                              imagePickerProvider.getImageUrl,
                                          eventName:
                                              festivalNameController.text,
                                          date: dateController.text,
                                          docID: uv4,
                                          location: locationController.text,
                                          description:
                                              descriptionController.text,
                                          time: '$startTime - $endTime',
                                        );

                                        await FirestoreServices.uploadEventData(
                                          createEvent: createEvents,
                                          docId: uv4,
                                        );

                                        SnackBarHelper.showSnackBar(context,
                                            'Event created successfully');
                                      } catch (error) {
                                        print('Error: $error');
                                        AppUtils.toastMessage(
                                            'Error creating event');
                                      } finally {
                                        isLoading.value = false;
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          const Gap(10)
                        ])),
              ),
            ),
          ),
        ));
  }

  TextStyle _buildHintStyle() {
    return const TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.w400,
        fontSize: AppSize.medium);
  }
}
