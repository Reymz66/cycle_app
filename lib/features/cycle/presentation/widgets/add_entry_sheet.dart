import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../data/cycle_entry_model.dart';
import '../providers/cycle_providers.dart';

Future<void> showAddEntrySheet(
  BuildContext context, {
  required DateTime initialDate,
  CycleEntry? existingEntry,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => AddEntrySheet(
      initialDate: initialDate,
      existingEntry: existingEntry,
    ),
  );
}

class AddEntrySheet extends ConsumerStatefulWidget {
  const AddEntrySheet({
    super.key,
    required this.initialDate,
    this.existingEntry,
  });

  final DateTime initialDate;
  final CycleEntry? existingEntry;

  @override
  ConsumerState<AddEntrySheet> createState() => _AddEntrySheetState();
}

class _AddEntrySheetState extends ConsumerState<AddEntrySheet> {
  late DateTime _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.existingEntry?.startDate ?? widget.initialDate;
    _endDate = widget.existingEntry?.endDate;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMd(locale);
    final isEditing = widget.existingEntry != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            isEditing ? loc.editEntryTitle : loc.addEntryTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(loc.startDateLabel),
            trailing: Text(dateFormat.format(_startDate)),
            onTap: () => _pickStartDate(context),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(loc.endDateLabel),
            trailing: Text(
              _endDate != null
                  ? dateFormat.format(_endDate!)
                  : loc.endDateOngoingHint,
            ),
            onTap: () => _pickEndDate(context),
          ),
          Row(
            children: [
              if (isEditing)
                TextButton(
                  onPressed: () async {
                    await ref
                        .read(cycleEntriesProvider.notifier)
                        .delete(widget.existingEntry!.id);
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: Text(loc.deleteButton),
                ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(loc.cancelButton),
              ),
              FilledButton(
                onPressed: () => _save(context, loc),
                child: Text(loc.saveButton),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate,
      firstDate: _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  Future<void> _save(BuildContext context, AppLocalizations loc) async {
    if (_endDate != null && _endDate!.isBefore(_startDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.errorEndBeforeStart)),
      );
      return;
    }

    final entry = CycleEntry(
      id: widget.existingEntry?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      startDate: _startDate,
      endDate: _endDate,
    );

    await ref.read(cycleEntriesProvider.notifier).addOrUpdate(entry);
    if (context.mounted) Navigator.of(context).pop();
  }
}
