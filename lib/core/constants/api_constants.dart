/// ApiConstants
/// Digunakan untuk menyimpan seluruh konfigurasi dan endpoint
/// yang berkaitan dengan NewsAPI, seperti base URL, API key,
/// parameter default, dan path endpoint.
class ApiConstants {
  static const String baseUrl = "https://newsapi.org/v2";
  static const String apiKey = "42e8c3c6922b494780132ca5b9bb7144";
  static const String defaultCountry = "id";

  static const String topHeadlines = "/top-headlines";
  static const String everything = "/everything";
  static const String sources = "/sources";
}

/// AppConstants
/// Digunakan untuk menyimpan konstanta umum aplikasi,
/// seperti nama aplikasi dan daftar kategori berita
/// yang digunakan di dalam tampilan atau fitur filter.
class AppConstants {
  static const String appName = 'News Reader';

  static const List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
}
