import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_downloads/src/core/theme/theme_tokens.dart';
import 'package:top_downloads/src/features/charts/domain/chart_entry.dart';
import 'package:url_launcher/url_launcher.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({required this.entry, required this.rank, super.key});

  final ChartEntry entry;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final medalColor = switch (rank) {
      1 => const Color(0xFFFFC857),
      2 => const Color(0xFFB9C2CC),
      3 => const Color(0xFFCD8B62),
      _ => scheme.surfaceContainerHighest,
    };

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: entry.url.isEmpty ? null : () => _openEntry(context),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              SizedBox(
                width: 38,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: medalColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$rank',
                      style: TextStyle(
                        color: rank <= 3 ? const Color(0xFF241B08) : scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Hero(
                tag: entry.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: CachedNetworkImage(
                    imageUrl: entry.artworkUrl,
                    width: 76,
                    height: 76,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ColoredBox(
                      color: scheme.surfaceContainerHighest,
                      child: const Center(
                        child: SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => ColoredBox(
                      color: scheme.surfaceContainerHighest,
                      child: const Icon(Icons.image_not_supported_outlined),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      entry.artistName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                    if (entry.genres.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        entry.genres.first,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(Icons.arrow_outward_rounded, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openEntry(BuildContext context) async {
    final opened = await launchUrl(
      Uri.parse(entry.url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The store link could not be opened.')),
      );
    }
  }
}
