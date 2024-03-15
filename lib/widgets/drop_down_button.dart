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
    return SizedBox(
      width: 110,
      child: DropdownButton(
        isExpanded: true,
        icon: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(
            icon,
            color: AppColors.lightGrey,
          ),
        ),
        underline: const SizedBox(),
        alignment: Alignment.topRight,
        items: itemList.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class FestivalDropDownWidget extends StatelessWidget {
  final List<String> itemList;
  final IconData icon;
  final String value;
  final TextEditingController controller;
  final void Function(String?) onChanged;

  const FestivalDropDownWidget({
    super.key,
    required this.itemList,
    required this.icon,
    required this.controller,
    required this.onChanged,
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: DropdownButton(
        isExpanded: true,
        icon: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(
            icon,
            color: AppColors.lightGrey,
          ),
        ),
        underline: const SizedBox(),
        alignment: Alignment.topRight,
        items: itemList.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
