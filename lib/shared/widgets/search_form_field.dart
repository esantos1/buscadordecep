import 'package:flutter/material.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final String? helperText;
  final ValueChanged? onChanged;
  final String? Function(String?)? validator;

  const SearchFormField({
    super.key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.helperText,
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
        helperText: helperText,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
