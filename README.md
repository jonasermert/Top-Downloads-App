# Top Downloads

A modern Android-only Flutter app that presents Apple's live top charts. It is
a complete Flutter reimplementation of the original native Android
`Top10Downloader` learning project.

## Features

- Top free apps, paid apps, and songs
- Switchable Top 10 and Top 25 charts
- Live data from Apple's Marketing Tools RSS JSON API
- Pull-to-refresh, loading, empty, and error states
- Store links that open in the external browser or app
- Responsive one-, two-, and three-column layouts
- Persistent light/dark mode using the Jonas theme
- Material 3 cards, ranking badges, and a gradient chart header

## Stack

- Flutter and Dart
- Material 3 with centralized Jonas design tokens
- Riverpod for application and asynchronous state
- `http` for Apple chart requests
- `cached_network_image` for artwork
- `shared_preferences` for the theme setting
- `url_launcher` for store links

## Requirements

- Flutter stable with Dart 3.4 or newer
- Java 17
- Android SDK

Only Android is configured. The Android namespace and application ID are
`com.jonas.ermert.top_downloads`, and the host code uses Java.

## Run

```shell
flutter pub get
flutter run
```

## Quality checks

```shell
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
```

## Architecture

The project uses a practical feature-oriented structure:

```text
lib/
├── main.dart
└── src/
    ├── core/theme/
    └── features/
        ├── charts/
        │   ├── application/
        │   ├── data/
        │   ├── domain/
        │   └── presentation/
        └── settings/application/
```

## Data source

Chart data and artwork are supplied by Apple. Availability and content can vary
by country and over time. The app currently uses the United States charts to
preserve the behavior of the source project.

## License

MIT — see [LICENSE](LICENSE).
