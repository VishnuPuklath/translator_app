import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslatorService {
  Future<List<Map<String, dynamic>>> fetchLanguages() async {
    final url = Uri.parse(
      'https://google-translate1.p.rapidapi.com/language/translate/v2/languages?target=en',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'X-Rapidapi-Key':
              '8c1b60d698msh1f10d16e75a9c87p1acd0cjsn120092318891',
          'X-Rapidapi-Host': 'google-translate1.p.rapidapi.com',
          'Accept-Encoding': 'application/gzip',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final languages =
            List<Map<String, dynamic>>.from(data['data']['languages']);
        return languages;
      } else {
        throw Exception("Failed to fetch languages");
      }
    } catch (e) {
      throw Exception("An error occurred while fetching languages: $e");
    }
  }

  Future<String> translateText(String text, String targetLanguage) async {
    print(text);
    print(targetLanguage);

    final url = Uri.parse(
        'https://google-translate1.p.rapidapi.com/language/translate/v2');

    final body = {
      'q': text,
      'target': targetLanguage,
    };

    final encodedBody = body.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    try {
      final response = await http.post(
        url,
        headers: {
          'X-Rapidapi-Key':
              '8c1b60d698msh1f10d16e75a9c87p1acd0cjsn120092318891',
          'X-Rapidapi-Host': 'google-translate1.p.rapidapi.com',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: encodedBody,
      );

      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['translations'][0]['translatedText'];
      } else {
        throw Exception("Failed to translate text");
      }
    } catch (e) {
      throw Exception("An error occurred during translation: $e");
    }
  }
}
