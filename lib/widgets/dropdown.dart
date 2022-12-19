import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String value;
  final String? label;
  final void Function(String?)? onChanged;
  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.value,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      onChanged: onChanged,
      value: value,
      items: items.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
      ),
    );
  }
}
