import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:top_downloads/src/features/charts/data/charts_repository.dart';
import 'package:top_downloads/src/features/charts/domain/chart_category.dart';

void main() {
  test('fetchChart parses feed results and builds the expected URL', () async {
    final client = MockClient((request) async {
      expect(
        request.url.toString(),
        'https://rss.marketingtools.apple.com/api/v2/us/apps/top-free/10/apps.json',
      );
      return http.Response(
        '{"feed":{"results":[{"id":"1","name":"Top App",'
        '"artistName":"Studio","artworkUrl100":"image",'
        '"url":"store","releaseDate":"2026-01-01","genres":[]}]}}',
        200,
      );
    });
    final repository = ChartsRepository(client: client);

    final entries = await repository.fetchChart(
      category: ChartCategory.freeApps,
      limit: 10,
    );

    expect(entries, hasLength(1));
    expect(entries.single.name, 'Top App');
  });

  test('fetchChart exposes a readable failure for non-200 responses', () async {
    final repository = ChartsRepository(
      client: MockClient((request) async => http.Response('Unavailable', 503)),
    );

    expect(
      repository.fetchChart(category: ChartCategory.songs, limit: 25),
      throwsA(
        isA<ChartsException>().having(
          (error) => error.message,
          'message',
          contains('503'),
        ),
      ),
    );
  });
}
