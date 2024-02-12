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
                  height: 15,
                ),
                const CustomText(
                  title: 'Festival Name',
                  color: AppColors.gryishBlue,
                  weight: FontWeight.w600,
                  size: AppSize.medium,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: festivalNameController,
                  keyBoardType: TextInputType.text,
                  hintText: 'Festival Name',
                  weight: FontWeight.w400,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter festival name';
                    }

                    return null;
                  },
                  hintStyle: _buildHintStyle(),
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
                  height: 15,
                ),
                CustomTextField(
                  keyBoardType: TextInputType.datetime,
                  controller: dateController,
                  hintText: 'Date',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Enter Date ';
                    }

                    return null;
                  },
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      AppSvgs.date,
                    ),
                  ),
                  hintStyle: _buildHintStyle(),
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
                  height: 15,
                ),
                CustomTextField(
                  controller: ticketTypeController,
                  keyBoardType: TextInputType.name,
                  hintText: 'Select Type',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  hintStyle: _buildHintStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ticket Type';
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
                  height: 15,
                ),
                CustomTextField(
                  hintText: 'Enter Ticket Price',
                  controller: priceController,
                  keyBoardType: TextInputType.number,
                  hintStyle: _buildHintStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please set price';
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
                  height: 15,
                ),
                CustomTextField(
                  maxLines: 5,
                  controller: descriptionController,
                  keyBoardType: TextInputType.text,
                  isCommentField: true,
                  hintText: 'Enter Your Description Here',
                  hintStyle: _buildHintStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
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
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _buildHintStyle() {
    return const TextStyle(
        color: AppColors.blueGrey,
        fontWeight: FontWeight.w400,
        fontSize: AppSize.medium);
  }
}
