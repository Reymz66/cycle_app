import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'locale_repository.dart';

final localeRepositoryProvider = Provider<LocaleRepository>((ref) {
  throw UnimplementedError(
    'localeRepositoryProvider must be overridden in main() once the '
    'Hive box has been opened.',
  );
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(this._repository) : super(Locale(_repository.get()));

  final LocaleRepository _repository;

  Future<void> setLocale(Locale locale) async {
    await _repository.save(locale.languageCode);
    state = locale;
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final repository = ref.watch(localeRepositoryProvider);
  return LocaleNotifier(repository);
});
