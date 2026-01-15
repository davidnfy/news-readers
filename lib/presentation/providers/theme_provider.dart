// Package Flutter untuk pengaturan tema dan state management
import 'package:flutter/material.dart';

/// ThemeProvider
/// Provider untuk mengelola tema aplikasi
/// (mode terang dan mode gelap).
class ThemeProvider with ChangeNotifier {
  // Menyimpan mode tema yang sedang digunakan
  ThemeMode _themeMode = ThemeMode.light;

  // Mengambil mode tema saat ini
  ThemeMode get themeMode => _themeMode;

  // Mengecek apakah tema gelap sedang aktif
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Mengubah tema berdasarkan input pengguna
  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
