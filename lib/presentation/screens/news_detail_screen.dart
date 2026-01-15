// Package Flutter untuk membangun UI
import 'package:flutter/material.dart';

// Package untuk membuka URL di browser
import 'package:url_launcher/url_launcher.dart';

// Provider untuk state management
import 'package:provider/provider.dart';

// Package untuk load gambar dari internet dengan cache
import 'package:cached_network_image/cached_network_image.dart';

// Model data berita
import 'package:news_reader/data/models/news_model.dart';

// Provider berita untuk bookmark
import 'package:news_reader/presentation/providers/news_provider.dart';

// Package untuk format tanggal
import 'package:intl/intl.dart';

/// NewsDetailScreen
/// Halaman untuk menampilkan detail lengkap sebuah berita.
class NewsDetailScreen extends StatelessWidget {
  // Data berita yang ditampilkan
  final NewsModel news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar halaman detail
      appBar: AppBar(
        title: const Text('News Detail'),

        // Tombol bookmark di AppBar
        actions: [
          Consumer<NewsProvider>(
            builder: (context, newsProvider, child) {
              // Cek status bookmark
              final isBookmarked = newsProvider.isBookmarked(news);

              return IconButton(
                // Icon berubah sesuai status bookmark
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.blue : Colors.white,
                ),

                // Aksi bookmark
                onPressed: () {
                  newsProvider.toggleBookmark(news);

                  // Tampilkan notifikasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isBookmarked
                            ? 'Removed from bookmarks'
                            : 'Added to bookmarks',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      // Konten halaman dapat di-scroll
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== GAMBAR BERITA =====
            if (news.urlToImage != null && news.urlToImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage!,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,

                  // Placeholder saat loading
                  placeholder: (context, url) => Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                  // Tampilan jika gambar gagal dimuat
                  errorWidget: (context, url, error) => Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Failed to load image'),
                      ],
                    ),
                  ),
                ),
              )
            else
              // Tampilan jika tidak ada gambar
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.article, size: 64, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('No Image Available'),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // ===== JUDUL BERITA =====
            Text(
              news.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // ===== INFO SUMBER & TANGGAL =====
            Row(
              children: [
                // Nama sumber berita
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    news.source.name?.isNotEmpty == true
                        ? news.source.name!
                        : 'Unknown',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Spacer(),

                // Tanggal publikasi
                Text(
                  DateFormat('MMM dd, yyyy - HH:mm')
                      .format(news.publishedAt),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ===== PENULIS =====
            if (news.author != null && news.author!.isNotEmpty)
              Text(
                'By ${news.author!}',
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),

            const SizedBox(height: 24),

            // ===== ISI BERITA =====
            Text(
              news.content != null && news.content!.isNotEmpty
                  ? news.content!
                  : news.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 32),

            // ===== TOMBOL BACA LENGKAP =====
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_new),
                label: const Text('Read Full Article'),
                onPressed: () => _launchURL(news.url),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Membuka URL berita di browser eksternal
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
