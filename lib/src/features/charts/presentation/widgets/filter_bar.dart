import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_downloads/src/core/theme/theme_tokens.dart';
import 'package:top_downloads/src/features/charts/application/charts_controller.dart';
import 'package:top_downloads/src/features/charts/domain/chart_category.dart';

class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(chartCategoryProvider);
    final limit = ref.watch(chartLimitProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Browse charts', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<ChartCategory>(
            showSelectedIcon: false,
            segments: [
              for (final item in ChartCategory.values)
                ButtonSegment(
                  value: item,
                  label: Text(item.label),
                  icon: Icon(item.icon),
                ),
            ],
            selected: {category},
            onSelectionChanged: (selection) =>
                ref.read(chartCategoryProvider.notifier).state = selection.first,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Text(
              category.label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: 10, label: Text('Top 10')),
                ButtonSegment(value: 25, label: Text('Top 25')),
              ],
              selected: {limit},
              onSelectionChanged: (selection) =>
                  ref.read(chartLimitProvider.notifier).state = selection.first,
            ),
          ],
        ),
      ],
    );
  }
}
