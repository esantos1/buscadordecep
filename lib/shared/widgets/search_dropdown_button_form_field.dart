import 'package:flutter/material.dart';

class SearchDropdownButtonFormField<T> extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;
  final VoidCallback? onTap;
  final String? Function(dynamic)? validator;

  const SearchDropdownButtonFormField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
    this.value,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
        icon: icon,
        hint: Text(hintText),
        value: value,
        items: items,
        decoration: InputDecoration(border: OutlineInputBorder()),
        onChanged: onChanged,
        onTap: onTap,
        validator: validator,
      );
}
