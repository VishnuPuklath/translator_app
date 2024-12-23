import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  final String selectedLanguage;
  final VoidCallback onTap;
  const LanguageButton({
    super.key,
    required this.selectedLanguage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        child: Center(
            child: Text(
          selectedLanguage,
          style: TextStyle(fontSize: 16),
        )),
        decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade700, width: 1.5)),
      ),
    );
  }
}
