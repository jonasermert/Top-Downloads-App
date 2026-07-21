import 'package:flutter/material.dart';
import 'package:top_downloads/src/core/theme/theme_tokens.dart';

class ChartLoadingState extends StatelessWidget {
  const ChartLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      sliver: SliverList.separated(
        itemCount: 6,
        itemBuilder: (context, index) => Container(
          height: 104,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: .55),
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.md),
      ),
    );
  }
}

class EmptyChartState extends StatelessWidget {
  const EmptyChartState({super.key});

  @override
  Widget build(BuildContext context) => const _ChartMessage(
        icon: Icons.inbox_outlined,
        title: 'No chart entries',
        message: 'Apple did not return any entries for this chart.',
      );
}

class ChartErrorState extends StatelessWidget {
  const ChartErrorState({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => _ChartMessage(
        icon: Icons.cloud_off_rounded,
        title: 'Could not load charts',
        message: message,
        action: FilledButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Try again'),
        ),
      );
}

class _ChartMessage extends StatelessWidget {
  const _ChartMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: scheme.primary),
            const SizedBox(height: AppSpacing.lg),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            if (action != null) ...[
              const SizedBox(height: AppSpacing.xl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
