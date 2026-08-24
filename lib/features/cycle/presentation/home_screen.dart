import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import 'providers/cycle_providers.dart';
import 'widgets/add_entry_sheet.dart';
import 'widgets/cycle_calendar.dart';
import 'widgets/cycle_legend.dart';
import 'widgets/cycle_summary_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final entries = ref.watch(cycleEntriesProvider);
    final prediction = ref.watch(cyclePredictionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.appTitle)),
      body: SafeArea(
        child: Column(
          children: [
            if (prediction != null) CycleSummaryCard(prediction: prediction),
            if (entries.isEmpty) _EmptyState(loc: loc),
            const CycleLegend(),
            Expanded(
              child: CycleCalendar(
                entries: entries,
                prediction: prediction,
                onDaySelected: (day) => _onDaySelected(context, ref, day),
              ),
            ),
          ],
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
