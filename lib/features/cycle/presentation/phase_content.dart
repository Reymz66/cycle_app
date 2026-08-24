import '../../../l10n/app_localizations.dart';
import '../domain/cycle_phase.dart';

class PhaseContent {
  const PhaseContent({
    required this.name,
    required this.description,
    required this.tags,
  });

  final String name;
  final String description;
  final List<String> tags;
}

PhaseContent phaseContentFor(CyclePhase phase, AppLocalizations loc) {
  switch (phase) {
    case CyclePhase.menstrual:
      return PhaseContent(
        name: loc.phaseMenstrualName,
        description: loc.phaseMenstrualDescription,
        tags: [loc.phaseMenstrualTag1, loc.phaseMenstrualTag2, loc.phaseMenstrualTag3],
      );
    case CyclePhase.follicular:
      return PhaseContent(
        name: loc.phaseFollicularName,
        description: loc.phaseFollicularDescription,
        tags: [loc.phaseFollicularTag1, loc.phaseFollicularTag2, loc.phaseFollicularTag3],
      );
    case CyclePhase.ovulatory:
      return PhaseContent(
        name: loc.phaseOvulatoryName,
        description: loc.phaseOvulatoryDescription,
        tags: [loc.phaseOvulatoryTag1, loc.phaseOvulatoryTag2, loc.phaseOvulatoryTag3],
      );
    case CyclePhase.luteal:
      return PhaseContent(
        name: loc.phaseLutealName,
        description: loc.phaseLutealDescription,
        tags: [loc.phaseLutealTag1, loc.phaseLutealTag2, loc.phaseLutealTag3],
      );
  }
}
