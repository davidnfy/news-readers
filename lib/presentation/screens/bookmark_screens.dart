// Package Flutter untuk membangun tampilan UI
import 'package:flutter/material.dart';

// Provider untuk state management
import 'package:provider/provider.dart';

// Provider berita untuk mengambil data bookmark
import 'package:news_reader/presentation/providers/news_provider.dart';

// Widget untuk menampilkan item berita
import 'package:news_reader/presentation/widgets/news_item.dart';

// Halaman detail berita
import 'package:news_reader/presentation/screens/news_detail_screen.dart';

/// BookmarkScreen
/// Halaman yang menampilkan daftar berita
/// yang telah disimpan (bookmark).
class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan judul halaman
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),

      // Mengambil data bookmark menggunakan Provider
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          // Daftar berita yang dibookmark
          final bookmarks = newsProvider.bookmarks;

          // Tampilan ketika belum ada bookmark
          if (bookmarks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ikon bookmark kosong
                  Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),

                  // Teks utama
                  Text(
                    'No bookmarks yet',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),

                  // Teks penjelas
                  Text(
                    'Tap the bookmark icon to save articles',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // Menampilkan list berita yang dibookmark
          return ListView.builder(
            // Jumlah item dalam list
            itemCount: bookmarks.length,

            // Builder setiap item
            itemBuilder: (context, index) {
              // Data berita per item
              final news = bookmarks[index];

              return NewsItem(
                // Data berita yang ditampilkan
                news: news,

                // Status bookmark aktif
                isBookmarked: true,

                // Navigasi ke halaman detail berita
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsDetailScreen(news: news),
                    ),
                  );
                },

                // Aksi ketika tombol bookmark ditekan
                onBookmark: () {
                  newsProvider.toggleBookmark(news);
                },
              );
            },
          );
        },
      ),
    );
  }
}