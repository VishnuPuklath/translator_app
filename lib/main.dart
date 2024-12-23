import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/features/translator/screens/translator_screen.dart';
import 'package:translator_app/providers/translator_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TranslatorProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: 'Google Translator',
        home: TranslatorScreen(),
      ),
    );
  }
}
