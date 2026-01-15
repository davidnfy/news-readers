// GENERATED CODE - DO NOT MODIFY BY HAND
// Kode ini dibuat otomatis oleh json_serializable

part of 'news_model.dart';
// Menandakan file ini adalah bagian dari news_model.dart

// **************************************************************************
// JsonSerializableGenerator
// Bagian hasil generate untuk konversi JSON ↔ Object
// **************************************************************************

// Fungsi untuk mengubah JSON menjadi objek NewsModel
NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
  // Mengubah data source dari JSON menjadi SourceModel
  source: SourceModel.fromJson(json['source'] as Map<String, dynamic>),

  // Mengambil nama penulis (boleh null)
  author: json['author'] as String?,

  // Mengambil judul berita
  title: json['title'] as String,

  // Mengambil deskripsi berita
  description: json['description'] as String,

  // Mengambil URL berita
  url: json['url'] as String,

  // Mengambil URL gambar (opsional)
  urlToImage: json['urlToImage'] as String?,

  // Mengubah string tanggal menjadi DateTime
  publishedAt: DateTime.parse(json['publishedAt'] as String),

  // Mengambil konten berita (opsional)
  content: json['content'] as String?,
);

// Fungsi untuk mengubah objek NewsModel menjadi JSON
Map<String, dynamic> _$NewsModelToJson(NewsModel instance) =>
    <String, dynamic>{
      // Menyimpan data source
      'source': instance.source,

      // Menyimpan author
      'author': instance.author,

      // Menyimpan title
      'title': instance.title,

      // Menyimpan description
      'description': instance.description,

      // Menyimpan url
      'url': instance.url,

      // Menyimpan url gambar
      'urlToImage': instance.urlToImage,

      // Mengubah DateTime ke format ISO String
      'publishedAt': instance.publishedAt.toIso8601String(),

      // Menyimpan konten berita
      'content': instance.content,
    };

// Fungsi untuk mengubah JSON menjadi objek SourceModel
SourceModel _$SourceModelFromJson(Map<String, dynamic> json) =>
    SourceModel(
      // ID sumber berita (opsional)
      id: json['id'] as String?,

      // Nama sumber berita
      name: json['name'] as String?,
    );

// Fungsi untuk mengubah objek SourceModel menjadi JSON
Map<String, dynamic> _$SourceModelToJson(SourceModel instance) =>
    <String, dynamic>{
      // Menyimpan id sumber
      'id': instance.id,

      // Menyimpan nama sumber
      'name': instance.name,
    };
