import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_downloads/src/core/theme/theme_tokens.dart';
import 'package:top_downloads/src/features/charts/application/charts_controller.dart';
import 'package:top_downloads/src/features/charts/domain/chart_category.dart';
import 'package:top_downloads/src/features/charts/presentation/widgets/chart_card.dart';
import 'package:top_downloads/src/features/charts/presentation/widgets/chart_header.dart';
import 'package:top_downloads/src/features/charts/presentation/widgets/chart_states.dart';
import 'package:top_downloads/src/features/charts/presentation/widgets/filter_bar.dart';
import 'package:top_downloads/src/features/settings/application/theme_controller.dart';

class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(chartCategoryProvider);
    final entries = ref.watch(chartEntriesProvider);
    final isDark = ref.watch(themeControllerProvider) == ThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(chartEntriesProvider.future),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                title: const Text('Top Downloads'),
                actions: [
                  IconButton.filledTonal(
                    tooltip: isDark ? 'Use light theme' : 'Use dark theme',
                    onPressed: () =>
                        ref.read(themeControllerProvider.notifier).toggle(),
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) =>
                          RotationTransition(turns: animation, child: child),
                      child: Icon(
                        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        key: ValueKey(isDark),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChartHeader(category: category),
                      const SizedBox(height: AppSpacing.xl),
                      const FilterBar(),
                    ],
                  ),
                ),
              ),
              entries.when(
                data: (items) => items.isEmpty
                    ? const SliverFillRemaining(child: EmptyChartState())
                    : SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          0,
                          AppSpacing.lg,
                          AppSpacing.xxl,
                        ),
                        sliver: SliverLayoutBuilder(
                          builder: (context, constraints) {
                            final columns = constraints.crossAxisExtent >= 900
                                ? 3
                                : constraints.crossAxisExtent >= 600
                                    ? 2
                                    : 1;
                            if (columns == 1) {
                              return SliverList.separated(
                                itemCount: items.length,
                                itemBuilder: (context, index) => ChartCard(
                                  entry: items[index],
                                  rank: index + 1,
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: AppSpacing.md),
                              );
                            }
                            return SliverGrid.builder(
                              itemCount: items.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                mainAxisExtent: 152,
                                crossAxisSpacing: AppSpacing.md,
                                mainAxisSpacing: AppSpacing.md,
                              ),
                              itemBuilder: (context, index) => ChartCard(
                                entry: items[index],
                                rank: index + 1,
                              ),
                            );
                          },
                        ),
                      ),
                loading: () => const ChartLoadingState(),
                error: (error, stackTrace) => SliverFillRemaining(
                  child: ChartErrorState(
                    message: error.toString(),
                    onRetry: () => ref.invalidate(chartEntriesProvider),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
