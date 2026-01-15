// Kelas utama untuk exception terkait berita
class NewsException implements Exception {
  // Pesan error yang akan ditampilkan
  final String message;
  // Kode status HTTP (opsional)
  final int? statusCode;

  // Konstruktor NewsException
  NewsException(this.message, [this.statusCode]);

  // Override method toString untuk menampilkan pesan error yang lebih informatif
  @override
  String toString() =>
      'NewsException: $message${statusCode != null ? ' ($statusCode)' : ''}';
}

// Exception untuk error jaringan (misal: timeout, tidak bisa connect)
class NetworkException extends NewsException {
  // Konstruktor menerima pesan error
  NetworkException(super.message);
}

// Exception untuk error API key (tidak valid atau tidak ada)
class ApiKeyException extends NewsException {
  // Konstruktor langsung mengisi pesan default
  ApiKeyException() : super('API key is invalid or missing');
}

// Exception untuk kasus tidak ada koneksi internet
class NoInternetException extends NewsException {
  // Konstruktor langsung mengisi pesan default
  NoInternetException() : super('No internet connection');
}
