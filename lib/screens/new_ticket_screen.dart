import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class AddNewTicket extends StatefulWidget {
  const AddNewTicket({super.key});

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

TextEditingController festivalNameController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController ticketTypeController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _AddNewTicketState extends State<AddNewTicket> {
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
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.skyBlue, width: 1),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppSvgs.image),
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
                    ),
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
                    hintText: 'Date',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppSvgs.date,
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
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
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
                  CustomButton(
                    backgroundColor: AppColors.white,
                    btnText: 'Submit',
                    weight: FontWeight.w700,
                    textColor: AppColors.white,
                    gradient: customGradient,
                    textSize: AppSize.regular,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
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
