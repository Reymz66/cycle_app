import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'features/cycle/data/cycle_entry_model.dart';
import 'features/cycle/data/cycle_repository.dart';
import 'features/cycle/data/symptom_log_model.dart';
import 'features/cycle/data/symptom_repository.dart';
import 'features/cycle/presentation/providers/cycle_providers.dart';
import 'features/cycle/presentation/providers/symptom_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CycleEntryAdapter());
  Hive.registerAdapter(SymptomLogAdapter());
  final repository = await CycleRepository.open();
  final symptomRepository = await SymptomRepository.open();

  runApp(
    ProviderScope(
      overrides: [
        cycleRepositoryProvider.overrideWithValue(repository),
        symptomRepositoryProvider.overrideWithValue(symptomRepository),
      ],
      child: const CycleApp(),
    ),
  );
}
