import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/cycle_phase.dart';
import '../../domain/symptom_type.dart';
import '../phase_content.dart';
import '../providers/symptom_providers.dart';
import '../symptom_labels.dart';

class NotifyPartnerButton extends ConsumerWidget {
  const NotifyPartnerButton({super.key, required this.phase});

  final CyclePhase phase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    ref.watch(symptomLogsProvider);
    final todaysLog =
        ref.read(symptomLogsProvider.notifier).entryForDay(DateTime.now());
    final todaysSymptoms = [
      for (final key in todaysLog?.symptomKeys ?? const <String>[])
        SymptomType.values.byName(key),
    ];
    final symptomSummary = todaysSymptoms
        .map((type) => '${type.emoji} ${symptomLabel(type, loc)}')
        .join('\n');

    final phaseName = phaseContentFor(phase, loc).name;
    final message = symptomSummary.isEmpty
        ? loc.partnerMessageTemplate(phaseName)
        : '${loc.partnerMessageTemplate(phaseName)}\n$symptomSummary';

    return FilledButton.tonalIcon(
      onPressed: () => Share.share(message),
      icon: const Icon(Icons.send_outlined),
      label: Text(loc.notifyPartnerMessengerButton),
    );
  }
}
