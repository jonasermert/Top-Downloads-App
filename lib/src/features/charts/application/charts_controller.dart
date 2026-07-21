import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_downloads/src/features/charts/data/charts_repository.dart';
import 'package:top_downloads/src/features/charts/domain/chart_category.dart';
import 'package:top_downloads/src/features/charts/domain/chart_entry.dart';

final chartsRepositoryProvider = Provider<ChartsRepository>(
  (ref) => ChartsRepository(),
);

final chartCategoryProvider = StateProvider<ChartCategory>(
  (ref) => ChartCategory.freeApps,
);

final chartLimitProvider = StateProvider<int>((ref) => 10);

final chartEntriesProvider = FutureProvider.autoDispose<List<ChartEntry>>((ref) {
  final category = ref.watch(chartCategoryProvider);
  final limit = ref.watch(chartLimitProvider);
  return ref.watch(chartsRepositoryProvider).fetchChart(
        category: category,
        limit: limit,
      );
});
