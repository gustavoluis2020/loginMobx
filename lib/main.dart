import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/text_notes/data/models/text_note_model.dart';
import 'injection_container.dart' as di;
import 'splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TextNoteModelAdapter());

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Mobx',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF43767E)),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
