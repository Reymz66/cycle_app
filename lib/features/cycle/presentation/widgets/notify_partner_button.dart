import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/profile_providers.dart';
import '../../domain/cycle_phase.dart';
import '../phase_content.dart';

class NotifyPartnerButton extends ConsumerWidget {
  const NotifyPartnerButton({super.key, required this.phase});

  final CyclePhase phase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final profile = ref.watch(userProfileProvider);

    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () => _notifyPartner(context, loc, profile?.partnerPhoneNumber),
        icon: const Icon(Icons.sms_outlined),
        label: Text(loc.notifyPartnerButton),
      ),
    );
  }

  Future<void> _notifyPartner(
    BuildContext context,
    AppLocalizations loc,
    String? partnerPhoneNumber,
  ) async {
    if (partnerPhoneNumber == null || partnerPhoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.notifyPartnerMissingNumber)),
      );
      return;
    }

    final phaseName = phaseContentFor(phase, loc).name;
    final message = loc.partnerMessageTemplate(phaseName);

    final uri = Uri(
      scheme: 'sms',
      path: partnerPhoneNumber,
      queryParameters: {'body': message},
    );

    await launchUrl(uri);
  }
}
