import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TabunganMiftahApp());
}

class TabunganMiftahApp extends StatelessWidget {
  const TabunganMiftahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tabungan Miftah',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
