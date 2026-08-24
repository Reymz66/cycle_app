import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../data/user_profile_model.dart';
import 'providers/profile_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _weightController;
  late final TextEditingController _partnerPhoneController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(userProfileProvider);
    _nameController = TextEditingController(text: profile?.name ?? '');
    _ageController = TextEditingController(
      text: profile?.age?.toString() ?? '',
    );
    _weightController = TextEditingController(
      text: profile?.weightLbs?.toString() ?? '',
    );
    _partnerPhoneController = TextEditingController(
      text: profile?.partnerPhoneNumber ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _partnerPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.profileScreenTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: loc.profileNameLabel),
                textCapitalization: TextCapitalization.words,
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: loc.profileAgeLabel),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(labelText: loc.profileWeightLabel),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              TextField(
                controller: _partnerPhoneController,
                decoration: InputDecoration(
                  labelText: loc.profilePartnerPhoneLabel,
                ),
                keyboardType: TextInputType.phone,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: _save,
                  child: Text(loc.saveButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    final loc = AppLocalizations.of(context)!;
    final partnerPhone = _partnerPhoneController.text.trim();
    final profile = UserProfile(
      name: _nameController.text.trim(),
      age: int.tryParse(_ageController.text.trim()),
      weightLbs: double.tryParse(_weightController.text.trim()),
      partnerPhoneNumber: partnerPhone.isEmpty ? null : partnerPhone,
    );

    await ref.read(userProfileProvider.notifier).save(profile);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(loc.profileSavedMessage)),
    );
  }
}
