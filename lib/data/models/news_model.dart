// Mengimpor package json_annotation untuk mendukung serialisasi otomatis
import 'package:json_annotation/json_annotation.dart';

// Bagian ini menghubungkan file ini dengan file hasil generate (news_model.g.dart)
part 'news_model.g.dart';

// Menandai class ini dapat diserialisasi/deserialisasi otomatis oleh json_serializable
@JsonSerializable()
class NewsModel {
  // Sumber berita (objek SourceModel)
  final SourceModel source;
  // Penulis berita (opsional)
  final String? author;
  // Judul berita
  final String title;
  // Deskripsi singkat berita
  final String description;
  // URL ke berita asli
  final String url;
  // URL gambar berita (opsional)
  final String? urlToImage;
  // Tanggal dan waktu publikasi berita
  final DateTime publishedAt;
  // Isi lengkap berita (opsional)
  final String? content;

  // Konstruktor NewsModel
  NewsModel({
    required this.source, // Wajib: sumber berita
    this.author, // Opsional: penulis
    required this.title, // Wajib: judul
    required this.description, // Wajib: deskripsi
    required this.url, // Wajib: url berita
    this.urlToImage, // Opsional: url gambar
    required this.publishedAt, // Wajib: tanggal publikasi
    this.content, // Opsional: isi berita
  });

  // Factory method untuk membuat instance dari JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  // Mengubah objek NewsModel menjadi Map (untuk dikonversi ke JSON)
  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

// Model untuk sumber berita
@JsonSerializable()
class SourceModel {
  // ID sumber berita (opsional)
  final String? id;
  // Nama sumber berita (opsional)
  final String? name;

  // Konstruktor SourceModel
  SourceModel({
    this.id, // Opsional: id sumber
    this.name, // Opsional: nama sumber
  });

  // Factory method untuk membuat instance dari JSON
  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);

  // Mengubah objek SourceModel menjadi Map (untuk dikonversi ke JSON)
  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}
