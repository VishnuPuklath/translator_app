import 'package:flutter/material.dart';
import 'package:translator_app/features/translator/services/translator_service.dart';

class TranslatorProvider with ChangeNotifier {
  final TranslatorService _service = TranslatorService();

  String _sourceLanguage = 'Abkhaz';
  String _targetLanguage = 'Acehnese';
  String _targetCode = 'ar';
  String get targetCode => _targetCode;
  List<Map<String, dynamic>> _languages = [];
  List<Map<String, dynamic>> get languages => _languages;
  String get sourceLanguage => _sourceLanguage;
  String get targetLanguage => _targetLanguage;
  String _translatedText = '';
  String get translatedText => _translatedText;

  Future<void> translateText(String inputText) async {
    try {
      _translatedText = await _service.translateText(
        inputText,
        targetCode,
      );
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to translate text");
    }
  }

  void setSourceLanguage(String language) {
    _sourceLanguage = language;
    notifyListeners();
  }

  void setTargetCode(String code) {
    _targetCode = code;
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

  TranslatorProvider() {
    _initialize();
  }

  void _initialize() async {
    await fetchLanguages();
  }

  Future<void> fetchLanguages() async {
    try {
      _languages =
          List<Map<String, dynamic>>.from(await _service.fetchLanguages());

      notifyListeners();
    } catch (e) {
      throw Exception("Failed to load languages");
    }
  }
}
