import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String labelText;
  final String? hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final ValueChanged? onChanged;
  final ValueChanged? onFieldSubmitted;
  final String? Function(String?)? validator;

  const SearchFormField({
    super.key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.helperText,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        label: Text(labelText),
        hintText: hintText,
        border: OutlineInputBorder(),
        helperText: helperText,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
