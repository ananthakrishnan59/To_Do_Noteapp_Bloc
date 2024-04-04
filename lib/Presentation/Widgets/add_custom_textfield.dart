import 'package:flutter/material.dart';

class AddCustomTextField extends StatelessWidget {
  const AddCustomTextField({
    super.key,
    required this.hintText,
    required this.fontSize,
    required this.fontWeight,
    this.onChanged,
    this.controller,
  });

  final String hintText;
  final double fontSize;
  final FontWeight fontWeight;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        decoration: InputDecoration(
          errorMaxLines: 1,
          errorText: '',
          errorStyle: const TextStyle(
            height: 0,
            fontSize: 0,
            color: Colors.transparent,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
        validator: (value) {
          if (value!.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}
