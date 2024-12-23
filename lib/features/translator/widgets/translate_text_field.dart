import 'package:flutter/material.dart';

class TranslateTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isReadOnly;
  final String? hintText;

  const TranslateTextField(
      {super.key,
      required this.controller,
      required this.isReadOnly,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 5,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[900],
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
