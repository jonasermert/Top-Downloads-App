import 'package:flutter/material.dart';

enum ChartCategory {
  freeApps(
    label: 'Free apps',
    eyebrow: 'APP STORE',
    path: 'apps/top-free',
    itemType: 'apps',
    icon: Icons.apps_rounded,
  ),
  paidApps(
    label: 'Paid apps',
    eyebrow: 'APP STORE',
    path: 'apps/top-paid',
    itemType: 'apps',
    icon: Icons.workspace_premium_rounded,
  ),
  songs(
    label: 'Songs',
    eyebrow: 'APPLE MUSIC',
    path: 'music/most-played',
    itemType: 'songs',
    icon: Icons.music_note_rounded,
  );

  const ChartCategory({
    required this.label,
    required this.eyebrow,
    required this.path,
    required this.itemType,
    required this.icon,
  });

  final String label;
  final String eyebrow;
  final String path;
  final String itemType;
  final IconData icon;
}
