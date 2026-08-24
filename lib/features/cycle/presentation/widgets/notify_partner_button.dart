import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/profile_providers.dart';
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
    final profile = ref.watch(userProfileProvider);
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

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      children: [
        TextButton.icon(
          onPressed: () => _notifyBySms(context, loc, profile?.partnerPhoneNumber, message),
          icon: const Icon(Icons.sms_outlined),
          label: Text(loc.notifyPartnerButton),
        ),
        TextButton.icon(
          onPressed: () => Share.share(message),
          icon: const Icon(Icons.send_outlined),
          label: Text(loc.notifyPartnerMessengerButton),
        ),
      ],
    );
  }

  Future<void> _notifyBySms(
    BuildContext context,
    AppLocalizations loc,
    String? partnerPhoneNumber,
    String message,
  ) async {
    if (partnerPhoneNumber == null || partnerPhoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.notifyPartnerMissingNumber)),
      );
      return;
    }

    final uri = Uri(
      scheme: 'sms',
      path: partnerPhoneNumber,
      queryParameters: {'body': message},
    );

    await launchUrl(uri);
  }
}
