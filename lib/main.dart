import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/locale/locale_providers.dart';
import 'core/locale/locale_repository.dart';
import 'features/cycle/data/cycle_entry_model.dart';
import 'features/cycle/data/cycle_repository.dart';
import 'features/cycle/data/symptom_log_model.dart';
import 'features/cycle/data/symptom_repository.dart';
import 'features/cycle/presentation/providers/cycle_providers.dart';
import 'features/cycle/presentation/providers/symptom_providers.dart';
import 'features/profile/data/user_profile_model.dart';
import 'features/profile/data/user_profile_repository.dart';
import 'features/profile/presentation/providers/profile_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CycleEntryAdapter());
  Hive.registerAdapter(SymptomLogAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  final repository = await CycleRepository.open();
  final symptomRepository = await SymptomRepository.open();
  final profileRepository = await UserProfileRepository.open();
  final localeRepository = await LocaleRepository.open();

  runApp(
    ProviderScope(
      overrides: [
        cycleRepositoryProvider.overrideWithValue(repository),
        symptomRepositoryProvider.overrideWithValue(symptomRepository),
        userProfileRepositoryProvider.overrideWithValue(profileRepository),
        localeRepositoryProvider.overrideWithValue(localeRepository),
      ],
      child: const CycleApp(),
    ),
  );
}
