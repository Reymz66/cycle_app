import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/cycle_history.dart';
import '../domain/symptom_type.dart';
import 'providers/cycle_providers.dart';
import 'providers/symptom_providers.dart';
import 'symptom_labels.dart';

class CycleHistoryScreen extends ConsumerWidget {
  const CycleHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final entries = ref.watch(cycleEntriesProvider);
    final symptomLogs = ref.watch(symptomLogsProvider);
    final history = buildCycleHistory(entries, symptomLogs);

    final byYear = <int, List<CycleHistoryEntry>>{};
    for (final item in history) {
      byYear.putIfAbsent(item.periodEntry.startDate.year, () => []).add(item);
    }
    final years = byYear.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(title: Text(loc.historyScreenTitle)),
      body: history.isEmpty
          ? _EmptyState(loc: loc)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: years.length,
              itemBuilder: (context, index) {
                final year = years[index];
                return _YearSection(
                  year: year,
                  entries: byYear[year]!,
                  loc: loc,
                  initiallyExpanded: index == 0,
                );
              },
            ),
    );
  }
}

class _YearSection extends StatelessWidget {
  const _YearSection({
    required this.year,
    required this.entries,
    required this.loc,
    required this.initiallyExpanded,
  });

  final int year;
  final List<CycleHistoryEntry> entries;
  final AppLocalizations loc;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: Text(
          '$year',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        initiallyExpanded: initiallyExpanded,
        children: [
          for (final entry in entries)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _CycleHistoryCard(entry: entry, loc: loc),
            ),
        ],
      ),
    );
  }
}

class _CycleHistoryCard extends StatelessWidget {
  const _CycleHistoryCard({required this.entry, required this.loc});

  final CycleHistoryEntry entry;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMd(locale);
    final period = entry.periodEntry;
    final dateRange = period.endDate == null
        ? '${dateFormat.format(period.startDate)} – ${loc.historyOngoingLabel}'
        : '${dateFormat.format(period.startDate)} – ${dateFormat.format(period.endDate!)}';

    final distinctSymptoms = <SymptomType>{
      for (final log in entry.symptomLogs)
        for (final key in log.symptomKeys) SymptomType.values.byName(key),
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Text(dateRange, style: Theme.of(context).textTheme.titleMedium),
            Text(
              entry.cycleLength != null
                  ? loc.historyCycleLengthLabel(entry.cycleLength!)
                  : loc.historyOngoingLabel,
            ),
            Text(loc.historyPeriodLengthLabel(entry.periodLength)),
            if (distinctSymptoms.isEmpty)
              Text(
                loc.historyNoSymptomsLabel,
                style: Theme.of(context).textTheme.bodySmall,
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final type in distinctSymptoms)
                    Chip(
                      label: Text('${type.emoji} ${symptomLabel(type, loc)}'),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.loc});

  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(
              loc.historyEmptyTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(loc.historyEmptyMessage, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
