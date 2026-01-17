# Aplikasi News Reader Flutter

Aplikasi berita Flutter menggunakan API publik untuk mengambil artikel berita. Aplikasi ini mendemonstrasikan penggunaan Provider untuk manajemen state, serialisasi JSON, theming, dan networking dengan HTTP.

## Prasyarat

- Install [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi 3.8.1 atau lebih baru disarankan)
- IDE seperti [Android Studio](https://developer.android.com/studio), [Visual Studio Code](https://code.visualstudio.com/), atau lainnya dengan plugin Flutter dan Dart terinstal
- Siapkan perangkat atau emulator untuk Android, iOS, web, atau desktop sesuai panduan setup platform Flutter

## Memulai

1. Clone repository ini atau download source code.

2. Arahkan ke direktori proyek di terminal atau command prompt.

3. Instal dependencies:

   ```sh
   flutter pub get
   ```

4. Generate kode serialisasi JSON (diperlukan untuk beberapa data models):

   ```sh
   flutter pub run build_runner build
   ```

## Menjalankan Aplikasi

Untuk menjalankan aplikasi pada perangkat atau emulator yang terhubung, gunakan:

```sh
flutter run
```

Untuk menjalankan pada platform tertentu, tentukan target perangkat atau platform, misalnya:

- Android:

  ```sh
  flutter run -d android
  ```

- iOS:

  ```sh
  flutter run -d ios
  ```

- Web:

  ```sh
  flutter run -d chrome
  ```

- Windows, macOS, atau Linux:

  ```sh
  flutter run -d windows
  flutter run -d macos
  flutter run -d linux
  ```

## Testing

Untuk menjalankan unit dan widget tests, jalankan:

```sh
flutter test
```

## Struktur Proyek

- `lib/main.dart`: Entry point aplikasi dan setup app widget
- `lib/presentation/`: UI screens, widgets, dan state providers
- `lib/data/`: Data sources dan models untuk network calls
- `lib/domain/`: Repository interfaces dan implementations
- `pubspec.yaml`: Project dependencies dan konfigurasi

## Catatan Tambahan

- Aplikasi menggunakan package Provider untuk manajemen state.
- Data berita diambil dari API publik melalui HTTP requests.
- Theming mendukung mode light dan dark.

## Kontribusi

Silakan fork dan submit pull requests dengan perbaikan atau bug fixes.

## Lisensi

Proyek ini dilisensikan di bawah MIT License.
