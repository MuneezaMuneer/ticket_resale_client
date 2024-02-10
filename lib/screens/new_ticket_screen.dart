import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class AddNewTicket extends StatefulWidget {
  const AddNewTicket({super.key});

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

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
                borderColor: AppColors.skyBlue,
                hintText: 'Festival Name',
                weight: FontWeight.w400,
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
                borderColor: AppColors.skyBlue,
                hintText: 'Date',
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
                borderColor: AppColors.skyBlue,
                hintText: 'Select Type',
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                hintStyle: _buildHintStyle(),
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
                borderColor: AppColors.skyBlue,
                hintText: 'Enter Ticket Price',
                hintStyle: _buildHintStyle(),
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
                isCommentField: true,
                borderColor: AppColors.skyBlue,
                hintText: 'Enter Your Description Here',
                hintStyle: _buildHintStyle(),
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
                onPressed: () {},
              ),
              const SizedBox(
                height: 15,
              ),
            ],
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
