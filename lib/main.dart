// Copyright (c) 2026 Bengin Sternas.
//
// Project: Belegium
// This project is licensed under the Apache License 2.0.
// See the LICENSE file in the root directory for details.

import 'package:flutter/material.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const BelegiumApp());
}

class BelegiumApp extends StatelessWidget {
  const BelegiumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belegium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
