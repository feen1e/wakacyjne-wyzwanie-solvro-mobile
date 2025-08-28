import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";
import "theme/app_theme.dart";
import "theme/local_theme_repository.dart";
import "theme/theme_notifier.dart";

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final appThemeEnum = themeAsync.valueOrNull ?? AppThemeMode.system;
    final phoneBrightness = MediaQuery.of(context).platformBrightness;

    final appTheme = switch (appThemeEnum) {
      AppThemeMode.light => AppTheme().light,
      AppThemeMode.dark => AppTheme().dark,
      AppThemeMode.system => phoneBrightness == Brightness.dark ? AppTheme().dark : AppTheme().light,
    };

    return MaterialApp.router(
      title: "Dream Place App",
      theme: appTheme,
      routerConfig: goRouter,
    );
  }
}
