# News Reader Flutter Application

A Flutter news application using a public API for fetching news articles. This app demonstrates usage of Provider for state management, JSON serialization, theming, and networking with HTTP.

## Prerequisites

- Install [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.8.1 or newer recommended)
- An IDE such as [Android Studio](https://developer.android.com/studio), [Visual Studio Code](https://code.visualstudio.com/), or others with Flutter and Dart plugins installed
- Set up your device or emulator for Android, iOS, web, or desktop as per Flutter platform setup guides

## Getting Started

1. Clone this repository or download the source code.

2. Navigate to the project directory in your terminal or command prompt.

3. Install dependencies:

   ```sh
   flutter pub get
   ```

4. Generate JSON serialization code (required for some data models):

   ```sh
   flutter pub run build_runner build
   ```

## Running the Application

To run the app on your connected device or emulator, use:

```sh
flutter run
```

To run on a specific platform, specify the device or platform target, for example:

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

- Windows, macOS, or Linux:

  ```sh
  flutter run -d windows
  flutter run -d macos
  flutter run -d linux
  ```

## Testing

To run unit and widget tests, execute:

```sh
flutter test
```

## Project Structure

- `lib/main.dart`: Application entry point and app widget setup
- `lib/presentation/`: UI screens, widgets, and state providers
- `lib/data/`: Data sources and models for network calls
- `lib/domain/`: Repository interfaces and implementations
- `pubspec.yaml`: Project dependencies and configuration

## Additional Notes

- The app uses Provider package for state management.
- News data is fetched from a public API via HTTP requests.
- Theming supports light and dark modes.

## Contributing

Feel free to fork and submit pull requests with improvements or bug fixes.

## License

This project is licensed under the MIT License.
