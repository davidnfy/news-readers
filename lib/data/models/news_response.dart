// Mengimpor package json_annotation untuk mendukung serialisasi JSON otomatis
import 'package:json_annotation/json_annotation.dart';
// Mengimpor model NewsModel yang digunakan dalam daftar artikel
import 'news_model.dart';

// Bagian ini menghubungkan file ini dengan file hasil generate (news_response.g.dart)
part 'news_response.g.dart';

// Menandai class ini dapat diserialisasi/deserialisasi otomatis oleh json_serializable
@JsonSerializable()
class NewsResponse {
  // Status response dari API (misal: 'ok' atau 'error')
  final String status;
  // Jumlah total hasil berita yang ditemukan
  final int totalResults;
  // Daftar artikel berita yang diterima dari API
  final List<NewsModel> articles;

  // Konstruktor NewsResponse
  NewsResponse({
    required this.status, // Wajib: status response
    required this.totalResults, // Wajib: jumlah total hasil
    required this.articles, // Wajib: daftar artikel berita
  });

  // Factory method untuk membuat instance dari JSON
  factory NewsResponse.fromJson(Map<String, dynamic> json) => 
      _$NewsResponseFromJson(json);

  // Mengubah objek NewsResponse menjadi Map (untuk dikonversi ke JSON)
  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}