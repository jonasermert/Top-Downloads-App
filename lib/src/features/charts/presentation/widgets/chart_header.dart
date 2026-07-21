import 'package:flutter/material.dart';
import 'package:top_downloads/src/core/theme/theme_tokens.dart';
import 'package:top_downloads/src/features/charts/domain/chart_category.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader({required this.category, super.key});

  final ChartCategory category;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.indigo, AppColors.violet],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.indigo.withValues(alpha: .28),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            bottom: -32,
            child: Icon(
              category.icon,
              size: 142,
              color: Colors.white.withValues(alpha: .12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(category.icon, color: AppColors.cyan, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    category.eyebrow,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.3,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'What the world\nis downloading.',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Live charts, refreshed directly from Apple.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: scheme.surface.withValues(alpha: .78),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
