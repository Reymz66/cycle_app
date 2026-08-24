import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/date_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../profile/presentation/profile_screen.dart';
import '../domain/cycle_phase.dart';
import 'cycle_history_screen.dart';
import 'providers/cycle_providers.dart';
import 'providers/symptom_providers.dart';
import 'widgets/add_entry_sheet.dart';
import 'widgets/cycle_calendar.dart';
import 'widgets/cycle_legend.dart';
import 'widgets/cycle_phase_card.dart';
import 'widgets/cycle_summary_card.dart';
import 'widgets/symptom_log_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final entries = ref.watch(cycleEntriesProvider);
    final prediction = ref.watch(cyclePredictionProvider);
    final symptomLogs = ref.watch(symptomLogsProvider);
    final daysWithSymptomLog = {
      for (final log in symptomLogs) dateOnly(log.date),
    };
    final phase = prediction == null
        ? null
        : currentPhase(DateTime.now(), entries, prediction);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          IconButton(
            tooltip: loc.profileOpenTooltip,
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
          IconButton(
            tooltip: loc.historyOpenTooltip,
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CycleHistoryScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 96),
          child: Column(
            children: [
              if (prediction != null) CycleSummaryCard(prediction: prediction),
              if (phase != null)
                CyclePhaseCard(
                  phase: phase,
                  onLogSymptoms: () =>
                      showSymptomLogSheet(context, date: DateTime.now()),
                ),
              if (entries.isEmpty) _EmptyState(loc: loc),
              const CycleLegend(),
              CycleCalendar(
                entries: entries,
                prediction: prediction,
                daysWithSymptomLog: daysWithSymptomLog,
                onDaySelected: (day) => _onDaySelected(context, ref, day),
                onDayLongPressed: (day) =>
                    showSymptomLogSheet(context, date: day),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddEntrySheet(context, initialDate: DateTime.now()),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onDaySelected(BuildContext context, WidgetRef ref, DateTime day) {
    final existingEntry =
        ref.read(cycleEntriesProvider.notifier).entryCoveringDay(day);
    showAddEntrySheet(
      context,
      initialDate: day,
      existingEntry: existingEntry,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.loc});

  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 4,
        children: [
          Text(
            loc.emptyStateTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            loc.emptyStateMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
