import 'package:flutter/material.dart';
import 'package:safetyfeapps/screens/login_k3_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safety Hub Apps', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginK3Page(), 
      debugShowCheckedModeBanner: false,
    );
  }
}