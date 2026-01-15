import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Core
import 'package:news_reader/core/constants/api_constants.dart';

// Data
import 'package:news_reader/data/datasources/news_remote_data_source.dart';

// Domain
import 'package:news_reader/domain/repositories/news_repository.dart';

// Presentation
import 'package:news_reader/presentation/providers/news_provider.dart';
import 'package:news_reader/presentation/providers/theme_provider.dart';
import 'package:news_reader/presentation/screens/news_list_screen.dart';

/// Entry point utama aplikasi
void main() {
  runApp(const MyApp());
}

/// Root widget aplikasi News Reader
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// MultiProvider digunakan untuk menyediakan dependency
    /// ke seluruh aplikasi (Dependency Injection)
    return MultiProvider(
      providers: [
        /// Provider untuk data source API (HTTP request ke News API)
        Provider<NewsRemoteDataSource>(
          create: (_) => NewsRemoteDataSource(client: http.Client()),
        ),

        /// Provider untuk repository yang mengelola data berita
        Provider<NewsRepository>(
          create: (context) => NewsRepositoryImpl(
            remoteDataSource: context.read<NewsRemoteDataSource>(),
          ),
        ),

        /// Provider state management berita (ChangeNotifier)
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(
            newsRepository: context.read<NewsRepository>(),
          ),
        ),

        /// Provider untuk pengaturan tema (Light / Dark Mode)
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],

      /// Consumer untuk mendengarkan perubahan tema aplikasi
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            /// Nama aplikasi
            title: AppConstants.appName,

            /// Mode tema (light / dark)
            themeMode: themeProvider.themeMode,

            /// Tema terang
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),

            /// Tema gelap
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              scaffoldBackgroundColor: Colors.black,
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),

            /// Halaman utama aplikasi
            home: const NewsListScreen(),

            /// Menghilangkan banner debug
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
