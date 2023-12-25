import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchFormField extends StatelessWidget {
  final bool clearButton;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String labelText;
  final String? hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final ValueChanged? onChanged;
  final ValueChanged? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

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
    this.clearButton = true,
    this.textInputAction,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        label: Text(labelText),
        hintText: hintText,
        border: OutlineInputBorder(),
        helperText: helperText,
        suffixIcon:
            clearButton && (controller != null && controller!.text.isNotEmpty)
                ? IconButton(
                    splashRadius: 16.0,
                    onPressed: controller!.clear,
                    icon: Icon(Icons.clear),
                  )
                : null,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      textInputAction: textInputAction,
    );
  }
}
