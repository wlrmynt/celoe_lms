import 'package:flutter/material.dart';
import 'package:celoe_lms/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celoe LMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red), // Adjusted to match potential branding
        useMaterial3: true,
        fontFamily: 'Roboto', // Default modern font, can be customized
      ),
      home: const SplashScreen(),
    );
  }
}
