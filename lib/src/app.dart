import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_downloads/src/core/theme/app_theme.dart';
import 'package:top_downloads/src/features/charts/presentation/charts_screen.dart';
import 'package:top_downloads/src/features/settings/application/theme_controller.dart';

class TopDownloadsApp extends ConsumerWidget {
  const TopDownloadsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Top Downloads',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const ChartsScreen(),
    );
  }
}
