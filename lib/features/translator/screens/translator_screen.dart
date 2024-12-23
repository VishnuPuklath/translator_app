import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/features/translator/widgets/language_button.dart';
import 'package:translator_app/features/translator/widgets/translate_text_field.dart';
import 'package:translator_app/providers/translator_provider.dart';

class TranslatorScreen extends StatefulWidget {
  TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_translateText);
  }

  void _translateText() {
    final translatorProvider =
        Provider.of<TranslatorProvider>(context, listen: false);
    translatorProvider.translateText(_inputController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<TranslatorProvider>(
              builder: (context, translatorProvider, child) {
            return SingleChildScrollView(
              child: Column(
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
                      controller: TextEditingController(
                          text: translatorProvider.translatedText),
                      isReadOnly: true)
                ],
              ),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('All Languages'),
            const SizedBox(height: 20),
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
                              ? translatorProvider.sourceLanguage ==
                                      language['name']
                                  ? Colors.deepOrange[300]
                                  : Colors.black
                              : translatorProvider.targetLanguage ==
                                      language['name']
                                  ? Colors.deepOrange[300]
                                  : Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(language['name']),
                        onTap: () {
                          print(language['name']);
                          print(language['language']);
                          translatorProvider.selectLanguage(
                              isSource, language['name']);
                          if (!isSource) {
                            translatorProvider
                                .setTargetCode(language['language']);
                          }
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
