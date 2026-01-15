// Digunakan untuk mengubah data JSON dari API menjadi objek Dart
import 'dart:convert';

// Library HTTP untuk melakukan request ke API
import 'package:http/http.dart' as http;

// Konstanta API seperti base URL, endpoint, dan API key
import 'package:news_reader/core/constants/api_constants.dart';

// Custom exception untuk menangani error aplikasi
import 'package:news_reader/core/exceptions/news_exceptions.dart';

// Model data berita
import 'package:news_reader/data/models/news_model.dart';

/// NewsRemoteDataSource
/// Bertugas mengambil data berita dari NewsAPI melalui HTTP request
class NewsRemoteDataSource {
  // HTTP client yang digunakan untuk request
  final http.Client client;

  // Constructor dengan dependency injection HTTP client
  NewsRemoteDataSource({required this.client});

  /// Mengambil berita berdasarkan kategori (Top Headlines)
  Future<List<NewsModel>> getNewsByCategory(String category) async {
    try {
      // Menyusun URL request dengan parameter country, category, dan API key
      final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.topHeadlines}"
        "?country=${ApiConstants.defaultCountry}"
        "&category=$category"
        "&apiKey=${ApiConstants.apiKey}",
      );

      // Mengirim request GET dengan batas waktu 15 detik
      final response =
          await client.get(uri).timeout(const Duration(seconds: 15));

      // Jika request berhasil
      if (response.statusCode == 200) {
        // Decode response JSON menjadi Map
        final Map<String, dynamic> data = json.decode(response.body);

        // Ambil daftar artikel dari response
        final List<dynamic> articles = data['articles'] ?? [];

        // Konversi JSON artikel menjadi List<NewsModel>
        return articles
            .map((article) => NewsModel.fromJson(article))
            .toList();
      } else {
        // Error jika status code bukan 200
        throw NewsException(
          'Failed to fetch news: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      // Error jaringan atau parsing data
      throw NewsException("Network error: $e");
    }
  }

  /// Mencari berita berdasarkan kata kunci (Everything endpoint)
  Future<List<NewsModel>> searchNews(String query) async {
    try {
      // Menyusun URL request pencarian berita
      final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.everything}"
        "?q=$query"
        "&apiKey=${ApiConstants.apiKey}",
      );

      // Mengirim request GET dengan timeout 15 detik
      final response =
          await client.get(uri).timeout(const Duration(seconds: 15));

      // Jika request berhasil
      if (response.statusCode == 200) {
        // Decode response JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Ambil daftar artikel
        final List<dynamic> articles = data['articles'] ?? [];

        // Ubah JSON menjadi objek NewsModel
        return articles
            .map((article) => NewsModel.fromJson(article))
            .toList();
      } else {
        // Error jika status code tidak berhasil
        throw NewsException(
          'Failed to search news: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      // Error saat proses pencarian berita
      throw NewsException("Search error: $e");
    }
  }
}
