// Data source untuk mengambil data berita dari API
import 'package:news_reader/data/datasources/news_remote_data_source.dart';

// Model data berita
import 'package:news_reader/data/models/news_model.dart';

// Custom exception untuk penanganan error
import 'package:news_reader/core/exceptions/news_exceptions.dart';

/// NewsRepository
/// Kontrak (interface) untuk pengelolaan data berita,
/// baik dari API maupun dari penyimpanan lokal (bookmark).
abstract class NewsRepository {
  // Mengambil berita headline utama
  Future<List<NewsModel>> getTopHeadlines();

  // Mengambil berita berdasarkan kategori
  Future<List<NewsModel>> getNewsByCategory(String category);

  // Mencari berita berdasarkan kata kunci
  Future<List<NewsModel>> searchNews(String query);

  // Mengambil daftar berita yang dibookmark
  Future<List<NewsModel>> getBookmarkedNews();

  // Menyimpan berita ke bookmark
  Future<void> bookmarkNews(NewsModel news);

  // Menghapus berita dari bookmark
  Future<void> removeBookmark(NewsModel news);

  // Mengecek apakah berita sudah dibookmark
  bool isBookmarked(NewsModel news);
}

/// NewsRepositoryImpl
/// Implementasi repository yang menggunakan data dari API
/// dan menyimpan bookmark secara lokal (sementara).
class NewsRepositoryImpl implements NewsRepository {
  // Remote data source untuk request ke API
  final NewsRemoteDataSource remoteDataSource;

  // Penyimpanan bookmark sementara di memori
  final List<NewsModel> _bookmarks = [];

  // Constructor dengan dependency injection
  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NewsModel>> getTopHeadlines() async {
    try {
      // Mengambil headline utama (default kategori)
      return await remoteDataSource.getNewsByCategory('all');
    } catch (e) {
      // Error saat mengambil headline
      throw NewsException('Failed to get top headlines: $e');
    }
  }

  @override
  Future<List<NewsModel>> getNewsByCategory(String category) async {
    try {
      // Mengambil berita sesuai kategori
      return await remoteDataSource.getNewsByCategory(category);
    } catch (e) {
      // Error saat mengambil berita kategori
      throw NewsException('Failed to get news by category: $e');
    }
  }

  @override
  Future<List<NewsModel>> searchNews(String query) async {
    try {
      // Jika query kosong, kembalikan headline
      if (query.isEmpty) return await getTopHeadlines();

      // Mencari berita berdasarkan keyword
      return await remoteDataSource.searchNews(query);
    } catch (e) {
      // Error saat pencarian berita
      throw NewsException('Failed to search news: $e');
    }
  }

  @override
  Future<List<NewsModel>> getBookmarkedNews() async {
    // Mengambil data bookmark dari memori
    // (implementasi nyata bisa dari local storage)
    return _bookmarks;
  }

  @override
  Future<void> bookmarkNews(NewsModel news) async {
    // Menyimpan berita ke bookmark jika belum ada
    if (!_bookmarks.any((item) => item.url == news.url)) {
      _bookmarks.add(news);
    }
  }

  @override
  Future<void> removeBookmark(NewsModel news) async {
    // Menghapus berita dari bookmark berdasarkan URL
    _bookmarks.removeWhere((item) => item.url == news.url);
  }

  @override
  bool isBookmarked(NewsModel news) {
    // Mengecek apakah berita sudah ada di bookmark
    return _bookmarks.any((item) => item.url == news.url);
  }
}
