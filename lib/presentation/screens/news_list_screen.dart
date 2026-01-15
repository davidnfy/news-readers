// Package Flutter untuk UI
import 'package:flutter/material.dart';

// Halaman bookmark
import 'package:news_reader/presentation/screens/bookmark_screens.dart';

// Provider untuk state management
import 'package:provider/provider.dart';

// Provider berita
import 'package:news_reader/presentation/providers/news_provider.dart';

// Widget item berita
import 'package:news_reader/presentation/widgets/news_item.dart';

// Halaman detail berita
import 'package:news_reader/presentation/screens/news_detail_screen.dart';

// Konstanta aplikasi (kategori)
import 'package:news_reader/core/constants/api_constants.dart';

// Provider tema (light / dark)
import 'package:news_reader/presentation/providers/theme_provider.dart';

/// NewsListScreen
/// Halaman utama untuk menampilkan daftar berita,
/// pencarian, kategori, bookmark, dan pengaturan tema.
class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  // Controller untuk input pencarian
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Memuat berita utama saat halaman pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().loadTopHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar halaman utama
      appBar: AppBar(
        title: const Text('News Reader'),
        actions: [
          // Tombol ganti tema (light / dark)
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final isDarkMode = themeProvider.isDarkMode;
              return IconButton(
                icon: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme(!isDarkMode);
                },
                tooltip: isDarkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
              );
            },
          ),

          // Tombol menuju halaman bookmark
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookmarkScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // Konten utama halaman
      body: Column(
        children: [
          // ===== SEARCH BAR =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<NewsProvider>().resetSearch();
                  },
                ),
              ),
              // Pencarian dijalankan jika input >= 3 karakter
              onChanged: (value) {
                if (value.length >= 3) {
                  context.read<NewsProvider>().searchNews(value);
                } else if (value.isEmpty) {
                  context.read<NewsProvider>().resetSearch();
                }
              },
            ),
          ),

          // ===== CATEGORY CHIP =====
          _buildCategoryChips(),

          // ===== LIST BERITA =====
          Expanded(
            child: _buildNewsList(),
          ),
        ],
      ),
    );
  }

  /// Widget untuk menampilkan kategori berita
  Widget _buildCategoryChips() {
    final categories = AppConstants.categories;

    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected =
                  newsProvider.selectedCategory == category;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(
                    category[0].toUpperCase() + category.substring(1),
                    style: TextStyle(
                      color: isSelected
                          ? colorScheme.onPrimary
                          : theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      newsProvider.loadNewsByCategory(category);
                    }
                  },
                  backgroundColor:
                      theme.colorScheme.surfaceContainerHighest,
                  selectedColor: colorScheme.primary,
                  checkmarkColor: colorScheme.onPrimary,
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Widget untuk menampilkan daftar berita
  Widget _buildNewsList() {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        // Loading state
        if (newsProvider.isLoading && newsProvider.news.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (newsProvider.hasError && newsProvider.news.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  newsProvider.errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: newsProvider.loadTopHeadlines,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        // Empty state
        if (newsProvider.news.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.article, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No news found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // Success state
        return RefreshIndicator(
          onRefresh: () => newsProvider.loadTopHeadlines(),
          child: ListView.builder(
            itemCount: newsProvider.news.length,
            itemBuilder: (context, index) {
              final news = newsProvider.news[index];
              final isBookmarked =
                  newsProvider.isBookmarked(news);

              return NewsItem(
                news: news,
                isBookmarked: isBookmarked,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsDetailScreen(news: news),
                    ),
                  );
                },
                onBookmark: () {
                  newsProvider.toggleBookmark(news);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Membersihkan controller
    _searchController.dispose();
    super.dispose();
  }
}
