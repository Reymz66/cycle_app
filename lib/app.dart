import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/cycle/presentation/home_screen.dart';
import 'l10n/app_localizations.dart';

class CycleApp extends StatelessWidget {
  const CycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
