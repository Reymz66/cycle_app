import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/cycle_phase.dart';
import '../phase_content.dart';
import 'notify_partner_button.dart';

class CyclePhaseCard extends StatelessWidget {
  const CyclePhaseCard({
    super.key,
    required this.phase,
    required this.onLogSymptoms,
  });

  final CyclePhase phase;
  final VoidCallback onLogSymptoms;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final content = phaseContentFor(phase, loc);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              content.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(content.description),
            Text(
              loc.expectedFeelingsLabel,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final tag in content.tags) Chip(label: Text(tag)),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              runSpacing: 8,
              children: [
                NotifyPartnerButton(phase: phase),
                FilledButton.tonal(
                  onPressed: onLogSymptoms,
                  child: Text(loc.howDoYouFeelButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
