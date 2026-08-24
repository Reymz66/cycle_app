import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../data/symptom_log_model.dart';
import '../../domain/symptom_type.dart';
import '../providers/symptom_providers.dart';
import '../symptom_labels.dart';

Future<void> showSymptomLogSheet(BuildContext context, {required DateTime date}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => SymptomLogSheet(date: date),
  );
}

class SymptomLogSheet extends ConsumerStatefulWidget {
  const SymptomLogSheet({super.key, required this.date});

  final DateTime date;

  @override
  ConsumerState<SymptomLogSheet> createState() => _SymptomLogSheetState();
}

class _SymptomLogSheetState extends ConsumerState<SymptomLogSheet> {
  late final Set<SymptomType> _selected;
  late final TextEditingController _noteController;
  SymptomLog? _existingLog;

  @override
  void initState() {
    super.initState();
    _existingLog =
        ref.read(symptomLogsProvider.notifier).entryForDay(widget.date);
    _selected = {
      for (final key in _existingLog?.symptomKeys ?? const <String>[])
        SymptomType.values.byName(key),
    };
    _noteController = TextEditingController(text: _existingLog?.note ?? '');
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMd(locale);

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
            loc.symptomSheetTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(dateFormat.format(widget.date)),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final type in SymptomType.values)
                FilterChip(
                  label: Text('${type.emoji} ${symptomLabel(type, loc)}'),
                  selected: _selected.contains(type),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selected.add(type);
                      } else {
                        _selected.remove(type);
                      }
                    });
                  },
                ),
            ],
          ),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(labelText: loc.symptomNoteLabel),
            minLines: 1,
            maxLines: 3,
          ),
          Row(
            children: [
              if (_existingLog != null)
                TextButton(
                  onPressed: () async {
                    await ref
                        .read(symptomLogsProvider.notifier)
                        .delete(_existingLog!.id);
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
                onPressed: _save,
                child: Text(loc.saveButton),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final id = DateFormat('yyyy-MM-dd').format(widget.date);
    final log = SymptomLog(
      id: id,
      date: widget.date,
      symptomKeys: _selected.map((type) => type.name).toList(),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    );

    await ref.read(symptomLogsProvider.notifier).upsert(log);
    if (mounted) Navigator.of(context).pop();
  }
}
