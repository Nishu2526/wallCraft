import 'package:flutter/material.dart';

import 'package:wallpaper_app/views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'W a l l  C r a f t',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
