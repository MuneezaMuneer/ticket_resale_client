import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';

class DropDownWidget extends StatelessWidget {
  final List<String> itemList;
  final IconData icon;
  final String value;
  final TextEditingController controller;
  final void Function(String?) onChanged;

  const DropDownWidget({
    super.key,
    required this.itemList,
    required this.icon,
    required this.controller,
    required this.onChanged,
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Icon(
          icon,
          color: AppColors.lightGrey,
        ),
      ),
      underline: const SizedBox(),
      alignment: Alignment.center,
      items: itemList.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem(
          alignment: Alignment.center,
          value: item,
          child: Center(child: Text(item)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
