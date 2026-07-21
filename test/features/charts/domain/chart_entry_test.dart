import 'package:flutter_test/flutter_test.dart';
import 'package:top_downloads/src/features/charts/domain/chart_entry.dart';

void main() {
  group('ChartEntry.fromJson', () {
    test('maps an Apple feed result', () {
      final entry = ChartEntry.fromJson({
        'id': '42',
        'name': 'Example App',
        'artistName': 'Jonas Studio',
        'artworkUrl100': 'https://example.com/icon.png',
        'url': 'https://example.com/app',
        'releaseDate': '2026-07-21',
        'genres': [
          {'name': 'Utilities'},
        ],
      });

      expect(entry.id, '42');
      expect(entry.name, 'Example App');
      expect(entry.artistName, 'Jonas Studio');
      expect(entry.releaseDate, DateTime(2026, 7, 21));
      expect(entry.genres, ['Utilities']);
    });

    test('uses safe fallbacks for optional values', () {
      final entry = ChartEntry.fromJson(const {});

      expect(entry.name, 'Unknown title');
      expect(entry.artistName, 'Unknown artist');
      expect(entry.genres, isEmpty);
      expect(entry.releaseDate, isNull);
    });
  });
}
