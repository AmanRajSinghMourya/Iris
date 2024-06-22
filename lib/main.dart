import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iris/utilities/constants.dart';
import 'package:iris/views/signup_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iris',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: 'IBMPlexSans',
        brightness: Brightness.dark,
      ),
      home: const SignUpView(),
    );
  }
}
