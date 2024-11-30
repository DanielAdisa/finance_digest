import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FinanceDigestApp());
}

class FinanceDigestApp extends StatelessWidget {
  const FinanceDigestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Digest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ), // Replaces headline1
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ), // Replaces headline2
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ), // Replaces bodyText1
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ), // Replaces bodyText2
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
