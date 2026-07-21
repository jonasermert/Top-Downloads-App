import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:top_downloads/src/features/charts/domain/chart_category.dart';
import 'package:top_downloads/src/features/charts/domain/chart_entry.dart';

class ChartsException implements Exception {
  const ChartsException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ChartsRepository {
  ChartsRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<ChartEntry>> fetchChart({
    required ChartCategory category,
    required int limit,
  }) async {
    final uri = Uri.https(
      'rss.marketingtools.apple.com',
      '/api/v2/us/${category.path}/$limit/${category.itemType}.json',
    );

    try {
      final response = await _client.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) {
        throw ChartsException('Apple returned status ${response.statusCode}.');
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final feed = json['feed'] as Map<String, dynamic>?;
      final results = feed?['results'] as List<dynamic>?;
      if (results == null) {
        throw const ChartsException('The chart response has an unknown format.');
      }

      return results
          .cast<Map<String, dynamic>>()
          .map(ChartEntry.fromJson)
          .toList(growable: false);
    } on ChartsException {
      rethrow;
    } on FormatException {
      throw const ChartsException('The chart data could not be read.');
    } on Exception {
      throw const ChartsException(
        'The charts are unavailable. Check your connection and try again.',
      );
    }
  }
}
