import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_reader/data/models/news_model.dart';
import 'package:intl/intl.dart';

/// Widget untuk menampilkan satu item berita dalam bentuk Card.
/// Digunakan di halaman daftar berita dan bookmark.
class NewsItem extends StatelessWidget {
  /// Data berita yang akan ditampilkan
  final NewsModel news;

  /// Menandakan apakah berita sudah dibookmark atau belum
  final bool isBookmarked;

  /// Aksi ketika item berita ditekan (navigate ke detail)
  final VoidCallback onTap;

  /// Aksi ketika tombol bookmark ditekan
  final VoidCallback onBookmark;

  /// Constructor NewsItem
  const NewsItem({
    super.key,
    required this.news,
    required this.isBookmarked,
    required this.onTap,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    // Mengambil tema aplikasi
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: theme.cardColor,
      child: InkWell(
        // Navigasi ke halaman detail berita
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan gambar berita jika tersedia
              // Jika gagal load, akan menampilkan icon error
              if (news.urlToImage != null && news.urlToImage!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      color: theme.dividerColor,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: theme.dividerColor,
                      child: Icon(
                        Icons.error,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                )
              // Fallback jika berita tidak memiliki gambar
              else
                Container(
                  height: 200,
                  width: double.infinity,
                  color: theme.dividerColor,
                  child: Icon(
                    Icons.article,
                    size: 64,
                    color: theme.disabledColor,
                  ),
                ),

              const SizedBox(height: 12),

              // Judul berita
              Text(
                news.title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Deskripsi singkat berita
              Text(
                news.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color
                      ?.withAlpha((0.8 * 255).round()),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Bagian bawah: sumber berita, tanggal, dan bookmark
              Row(
                children: [
                  // Informasi sumber dan tanggal publikasi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.source.name?.isNotEmpty == true
                              ? news.source.name!
                              : 'Unknown',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.textTheme.bodySmall?.color
                                ?.withAlpha((0.7 * 255).round()),
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy')
                              .format(news.publishedAt),
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color
                                ?.withAlpha((0.6 * 255).round()),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tombol bookmark
                  IconButton(
                    icon: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: isBookmarked
                          ? theme.colorScheme.primary
                          : theme.iconTheme.color,
                    ),
                    onPressed: onBookmark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
