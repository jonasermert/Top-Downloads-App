import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_downloads/src/app.dart';
import 'package:top_downloads/src/features/charts/application/charts_controller.dart';
import 'package:top_downloads/src/features/charts/domain/chart_entry.dart';
import 'package:top_downloads/src/features/settings/application/theme_controller.dart';

void main() {
  testWidgets('shows chart data and switches between categories', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    const entries = [
      ChartEntry(
        id: '1',
        name: 'Example App',
        artistName: 'Jonas Studio',
        artworkUrl: '',
        url: '',
        releaseDate: null,
        genres: ['Utilities'],
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          chartEntriesProvider.overrideWith((ref) async => entries),
        ],
        child: const TopDownloadsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Example App'), findsOneWidget);
    expect(find.text('Top 10'), findsOneWidget);
    expect(find.byIcon(Icons.apps_rounded), findsWidgets);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text('Songs'));
    await tester.pumpAndSettle();

    expect(find.text('Songs'), findsWidgets);
    expect(find.byIcon(Icons.music_note_rounded), findsWidgets);
  });
}
