import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/providers/drop_down_provider.dart';

// class CustomDropDown extends StatelessWidget {
//   const CustomDropDown({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DropDownProvider>(
//       builder: (context, provider, _) {
//         return Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: PopupMenuButton(
//             icon: const Icon(Icons.filter_alt_outlined),
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 child: DropdownButtonFormField<String>(
//                   value: provider.selectedOption,
//                   items: const [
//                     DropdownMenuItem(
//                       child: Text('Date'),
//                       value: 'Date',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Price'),
//                       value: 'Price',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Status'),
//                       value: 'Status',
//                     ),
//                   ],
//                   onChanged: (String? value) {
//                     provider.setSelectedOption(value ?? 'Date');
//                   },
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:ticket_resale/utils/app_utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DropDownProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt_outlined),
            onSelected: (String value) {
              provider.setSelectedOption(value);

              if (value == 'Date') {
                _showBottomSheetDate(context);
              } else if (value == 'Status') {
                _showBottomSheet(context, value);
              } else if (value == 'Price') {
                _showBottomSheetPrice(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Date',
                child: Text('Date'),
              ),
              const PopupMenuItem(
                value: 'Price',
                child: Text('Price'),
              ),
              const PopupMenuItem(
                value: 'Status',
                child: Text('Status'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, String selectedValue) {
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
              _buildBottomSheetButton(context, 'Pending', selectedValue),
              _buildBottomSheetButton(context, 'Disable', selectedValue),
              _buildBottomSheetButton(context, 'Active', selectedValue),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheetDate(BuildContext context) {
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: customGradient,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Start Date:',
                  style: TextStyle(color: Colors.white),
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
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.calendar_today, color: Colors.white),
                      ),
                    ),
                  ),
                  hintStyle: _buildTextFieldstyle(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'End Date:',
                  style: TextStyle(color: Colors.white),
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
                        child: Icon(Icons.calendar_today, color: Colors.white),
                      ),
                    ),
                  ),
                  hintStyle: _buildTextFieldstyle(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetButton(
      BuildContext context, String status, String selectedValue) {
    return ElevatedButton(
      onPressed: () {
        print('$selectedValue - $status');
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

void _showBottomSheetPrice(BuildContext context) {
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
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
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        const Gap(10),
                        SizedBox(
                          width: 160,
                          child: CustomTextField(
                            controller: minPriceController,
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
                    onPressed: () {},
                    child: const Text(
                      'Filter',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
