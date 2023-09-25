import 'package:flutter/material.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final ValueChanged? onChanged;
  final String? Function(String?)? validator;

  const SearchFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(labelText),
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
