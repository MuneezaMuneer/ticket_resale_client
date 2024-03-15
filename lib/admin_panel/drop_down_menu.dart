import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/admin_panel/snackBar.dart';
import 'package:ticket_resale/providers/clear_provider.dart';

import '../constants/constants.dart';

import '../providers/drop_down_provider.dart';
import '../utils/utils.dart';

import '../widgets/widgets.dart';

class CustomDropDown extends StatelessWidget {
  final Function(String) onSelectedStatus;

  final Function(double, double) onSelectedPrice;

  const CustomDropDown(
      {super.key,
      required this.onSelectedStatus,
      required this.onSelectedPrice});
  @override
  Widget build(BuildContext context) {
    return Consumer<DropDownProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: EdgeInsets.only(left: 20),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt_outlined),
            onSelected: (String value) {
              provider.setSelectedOption(value);

              if (value == 'Status') {
                _showBottomSheet(
                  context: context,
                  onSelected: (selectedValue) {
                    onSelectedStatus(selectedValue);
                    log(".................ON selected Filter : $selectedValue");
                  },
                );
              } else if (value == 'Price') {
                _showBottomSheetPrice(
                  context: context,
                  onSelected: (min, max) {
                    onSelectedPrice(min, max);
                  },
                );
              } else if (value == 'See all') {
                Provider.of<ClearProvider>(context, listen: false)
                    .clearSearchText();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Price',
                child: Text('Price'),
              ),
              const PopupMenuItem(
                value: 'Status',
                child: Text('Status'),
              ),
              const PopupMenuItem(
                value: 'See all',
                child: Text('See all'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet(
      {required BuildContext context, required Function(String) onSelected}) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          width: width,
          decoration: BoxDecoration(
            gradient: customGradient,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              _buildBottomSheetButton(
                context: context,
                status: 'Pending',
                onSelected: (value) {
                  onSelected(value);
                  log("................Selected value : $value");
                },
              ),
              _buildBottomSheetButton(
                context: context,
                status: 'Disable',
                onSelected: (value) {
                  onSelected(value);
                },
              ),
              _buildBottomSheetButton(
                context: context,
                status: 'Active',
                onSelected: (value) {
                  onSelected(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheetDate(
      {required BuildContext context,
      required Function(DateTime, DateTime) onSelected}) {
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: customGradient,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Start Date:',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Gap(15),
                  CustomTextField(
                    readOnly: true,
                    controller: startDateController,
                    hintText: 'Selected start date',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          AppUtils.openDatePicker(context,
                              dateController: startDateController);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child:
                              Icon(Icons.calendar_today, color: Colors.white),
                        ),
                      ),
                    ),
                    hintStyle: _buildTextFieldstyle(),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'End Date:',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Gap(15),
                  CustomTextField(
                    readOnly: true,
                    controller: endDateController,
                    hintText: 'Selected End date',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          AppUtils.openDatePicker(context,
                              dateController: endDateController);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child:
                              Icon(Icons.calendar_today, color: Colors.white),
                        ),
                      ),
                    ),
                    hintStyle: _buildTextFieldstyle(),
                  ),
                  const Gap(20),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        DateTime startDate =
                            DateTime.parse(startDateController.text);
                        DateTime endDate =
                            DateTime.parse(endDateController.text);

                        if (!startDate.isAfter(endDate)) {
                          onSelected(startDate, endDate);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          SnackBarHelper.showSnackBar(
                              context, 'Start date must less then end date');
                        }
                      },
                      child: const Text(
                        'Filter',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetButton(
      {required BuildContext context,
      required String status,
      required Function(String) onSelected}) {
    return ElevatedButton(
      onPressed: () {
        onSelected(status);
        print('.............................. $status');
        Navigator.of(context).pop();
      },
      child: Text(status),
    );
  }
}

TextStyle _buildTextFieldstyle() {
  return const TextStyle(
      color: AppColors.jetBlack,
      fontWeight: FontWeight.w400,
      fontSize: AppSize.medium);
}

void _showBottomSheetPrice(
    {required BuildContext context,
    required Function(double, double) onSelected}) {
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: customGradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(27),
                topRight: Radius.circular(27),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Start Price:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 160,
                              child: CustomTextField(
                                keyBoardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                controller: maxPriceController,
                                hintText: 'Min price',
                                hintStyle: _buildTextFieldstyle(),
                              ),
                            ),
                          ]),
                      //Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'End price:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          const Gap(10),
                          SizedBox(
                            width: 160,
                            child: CustomTextField(
                              keyBoardType: TextInputType.number,
                              controller: minPriceController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              hintText: 'Max price',
                              hintStyle: _buildTextFieldstyle(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        double? minPrice =
                            double.tryParse(minPriceController.text) ?? 0;
                        double? maxPrice =
                            double.tryParse(maxPriceController.text) ?? 0;
                        if (minPrice > maxPrice) {
                          onSelected(minPrice, maxPrice);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          SnackBarHelper.showSnackBar(context,
                              'Start price must be less then end price');
                        }
                      },
                      child: const Text(
                        'Filter',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
