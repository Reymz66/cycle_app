import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/cycle_calculator.dart';

class CycleSummaryCard extends StatelessWidget {
  const CycleSummaryCard({super.key, required this.prediction});

  final CyclePrediction prediction;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMd(locale);

    final today = DateTime.now();
    final daysUntilNextPeriod = DateTime(
      prediction.nextPeriodStart.year,
      prediction.nextPeriodStart.month,
      prediction.nextPeriodStart.day,
    ).difference(DateTime(today.year, today.month, today.day)).inDays;

    final nextPeriodLabel = daysUntilNextPeriod <= 0
        ? loc.summaryNextPeriodToday
        : loc.summaryNextPeriodIn(daysUntilNextPeriod);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              nextPeriodLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(loc.summaryOvulationEstimated(
              dateFormat.format(prediction.ovulationDate),
            )),
            Text(loc.summaryFertileWindow(
              dateFormat.format(prediction.fertileWindowStart),
              dateFormat.format(prediction.fertileWindowEnd),
            )),
          ],
        ),
      ),
    );
  }
}
