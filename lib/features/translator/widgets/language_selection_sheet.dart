import 'package:flutter/material.dart';

class LanguageSelectionSheet extends StatelessWidget {
  final List<Map<String, dynamic>> languages;
  final Function(String) onLanguageSelected;

  const LanguageSelectionSheet({
    Key? key,
    required this.languages,
    required this.onLanguageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          return ListTile(
            title: Text(language['name'] ?? 'Unknown'),
            onTap: () => onLanguageSelected(language['language']),
          );
        },
      ),
    );
  }
}
