import '../../../l10n/app_localizations.dart';
import '../domain/symptom_type.dart';

String symptomLabel(SymptomType type, AppLocalizations loc) {
  switch (type) {
    case SymptomType.cramps:
      return loc.symptomCramps;
    case SymptomType.fatigue:
      return loc.symptomFatigue;
    case SymptomType.moodSwings:
      return loc.symptomMoodSwings;
    case SymptomType.headache:
      return loc.symptomHeadache;
    case SymptomType.bloating:
      return loc.symptomBloating;
    case SymptomType.tenderBreasts:
      return loc.symptomTenderBreasts;
    case SymptomType.increasedEnergy:
      return loc.symptomIncreasedEnergy;
    case SymptomType.backPain:
      return loc.symptomBackPain;
    case SymptomType.nausea:
      return loc.symptomNausea;
    case SymptomType.foodCravings:
      return loc.symptomFoodCravings;
    case SymptomType.anxiety:
      return loc.symptomAnxiety;
    case SymptomType.acne:
      return loc.symptomAcne;
  }
}
