import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/features/translator/widgets/language_button.dart';
import 'package:translator_app/features/translator/widgets/translate_text_field.dart';
import 'package:translator_app/providers/translator_provider.dart';

class TranslatorScreen extends StatelessWidget {
  TextEditingController _inputController = TextEditingController();
  TextEditingController _outputController = TextEditingController();

  TranslatorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<TranslatorProvider>(
              builder: (context, translatorProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Text Translation',
                  style: TextStyle(fontSize: 26),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: LanguageButton(
                        selectedLanguage: translatorProvider.sourceLanguage,
                        onTap: () {
                          _showLanguageSelectionSheet(
                              context, translatorProvider,
                              isSource: true);
                        },
                      ),
                    ),
                    const Icon(
                      Icons.swap_horiz,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: LanguageButton(
                        selectedLanguage: translatorProvider.targetLanguage,
                        onTap: () {
                          _showLanguageSelectionSheet(
                              context, translatorProvider,
                              isSource: false);
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Translate From ',
                      style: TextStyle(color: Colors.grey.shade500)),
                  TextSpan(text: translatorProvider.sourceLanguage)
                ])),
                const SizedBox(
                  height: 20,
                ),
                TranslateTextField(
                  controller: _inputController,
                  hintText: 'Enter text to translate',
                  isReadOnly: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Translate To ',
                      style: TextStyle(color: Colors.grey.shade500)),
                  TextSpan(text: translatorProvider.targetLanguage),
                ])),
                const SizedBox(
                  height: 20,
                ),
                TranslateTextField(
                    controller: _outputController, isReadOnly: true)
              ],
            );
          }),
        ),
      ),
    );
  }
}

void _showLanguageSelectionSheet(
  BuildContext context,
  TranslatorProvider translatorProvider, {
  required bool isSource,
}) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('All Languages'),
            Expanded(
              child: ListView.builder(
                itemCount: translatorProvider.languages.length,
                itemBuilder: (context, index) {
                  final language = translatorProvider.languages[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: isSource
                              ? translatorProvider.sourceLanguage == language
                                  ? Colors.deepOrange[300]
                                  : null
                              : translatorProvider.targetLanguage == language
                                  ? Colors.deepOrange[300]
                                  : null,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(language),
                        onTap: () {
                          translatorProvider.selectLanguage(isSource, language);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
