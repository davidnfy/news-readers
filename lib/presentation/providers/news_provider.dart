// Package Flutter untuk state management dan UI
import 'package:flutter/material.dart';

// Model data berita
import 'package:news_reader/data/models/news_model.dart';

// Repository sebagai penghubung data (API & bookmark)
import 'package:news_reader/domain/repositories/news_repository.dart';

// Custom exception untuk error handling
import 'package:news_reader/core/exceptions/news_exceptions.dart';

/// NewsProvider
/// Provider untuk mengelola state berita, pencarian,
/// kategori, bookmark, loading, dan error.
class NewsProvider with ChangeNotifier {
  // Repository sebagai sumber data
  final NewsRepository newsRepository;

  // Constructor
  NewsProvider({required this.newsRepository});

  // ===== STATE =====

  // List berita utama
  List<NewsModel> _news = [];

  // List berita bookmark
  List<NewsModel> _bookmarks = [];

  // Kategori yang sedang dipilih
  String _selectedCategory = 'all';

  // Kata kunci pencarian
  String _searchQuery = '';

  // Status loading
  bool _isLoading = false;

  // Pesan error
  String _errorMessage = '';

  // Status sedang mencari
  bool _isSearching = false;

  // ===== GETTERS =====

  List<NewsModel> get news => _news;
  List<NewsModel> get bookmarks => _bookmarks;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get isSearching => _isSearching;

  // ===== LOAD HEADLINES =====

  // Memuat berita headline utama
  Future<void> loadTopHeadlines() async {
    _isLoading = true;
    _errorMessage = '';
    _isSearching = false;
    notifyListeners();

    try {
      _news = await newsRepository.getTopHeadlines();
    } on NewsException catch (e) {
      _errorMessage = e.message;
    } catch (_) {
      _errorMessage = 'An unexpected error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ===== LOAD BY CATEGORY =====

  // Memuat berita berdasarkan kategori
  Future<void> loadNewsByCategory(String category) async {
    _isLoading = true;
    _errorMessage = '';
    _selectedCategory = category;
    _isSearching = false;
    notifyListeners();

    try {
      _news = await newsRepository.getNewsByCategory(category);
    } on NewsException catch (e) {
      _errorMessage = e.message;
    } catch (_) {
      _errorMessage = 'An unexpected error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ===== SEARCH =====

  // Mencari berita berdasarkan keyword
  Future<void> searchNews(String query) async {
    _isLoading = true;
    _errorMessage = '';
    _searchQuery = query;
    _isSearching = query.isNotEmpty;
    notifyListeners();

    try {
      _news = await newsRepository.searchNews(query);
    } on NewsException catch (e) {
      _errorMessage = e.message;
    } catch (_) {
      _errorMessage = 'An unexpected error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ===== BOOKMARK =====

  // Memuat daftar bookmark
  Future<void> loadBookmarks() async {
    _bookmarks = await newsRepository.getBookmarkedNews();
    notifyListeners();
  }

  // Menambah atau menghapus bookmark
  Future<void> toggleBookmark(NewsModel news) async {
    if (newsRepository.isBookmarked(news)) {
      await newsRepository.removeBookmark(news);
    } else {
      await newsRepository.bookmarkNews(news);
    }
    await loadBookmarks();
  }

  // Mengecek status bookmark
  bool isBookmarked(NewsModel news) {
    return newsRepository.isBookmarked(news);
  }

  // ===== UTIL =====

  // Menghapus pesan error
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Reset pencarian dan kembali ke headline
  void resetSearch() {
    _searchQuery = '';
    _isSearching = false;
    loadTopHeadlines();
  }
}
