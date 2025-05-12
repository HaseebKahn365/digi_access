import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  final ThemeData _themeData = ThemeData.dark().copyWith(
    colorScheme: ThemeData.dark().colorScheme.copyWith(
      surface: const Color(0xFF2F2F4F),
    ),
    scaffoldBackgroundColor: const Color(0xFF2F2F4F),
  );

  ThemeData get themeData => _themeData;
}
