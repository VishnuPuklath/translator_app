import 'package:flutter/material.dart';
import 'package:translator_app/features/translator/services/translator_service.dart';

class TranslatorProvider with ChangeNotifier {
  final TranslatorService _service = TranslatorService();

  String _sourceLanguage = 'Germany';
  String _targetLanguage = 'Slovenjia';

  List<String> _languages = ['Germany', 'Slovenjia', 'France', 'Italy'];
  List<String> get languages => _languages;
  String get sourceLanguage => _sourceLanguage;
  String get targetLanguage => _targetLanguage;

  void setSourceLanguage(String language) {
    _sourceLanguage = language;
    notifyListeners();
  }

  void setTargetLanguage(String language) {
    _targetLanguage = language;
    notifyListeners();
  }

  void selectLanguage(bool isSource, String language) {
    if (isSource) {
      setSourceLanguage(language);
    } else {
      setTargetLanguage(language);
    }
  }
  // TranslatorProvider() {
  //   _initialize();
  // }

  // void _initialize() async {
  //   await fetchLanguages();
  // }

  // Future<void> fetchLanguages() async {
  //   try {
  //     languages = await _service.fetchLanguages();
  //     print('fetching.....');
  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception("Failed to load languages");
  //   }
  // }

  // void setSourceLanguageCode(String language) {
  //   sourceLanguageCode = language;
  //   notifyListeners();
  // }

  // void setTargetLanguageCode(String language) {
  //   targetLanguageCode = language;
  //   notifyListeners();
  // }

  // void setInputText(String text) {
  //   inputText = text;
  //   notifyListeners();
  // }

  // Future<void> translate() async {
  //   try {
  //     translatedText = await _service.translateText(inputText, targetLanguage);
  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception("Failed to translate text");
  //   }
  // }
}
