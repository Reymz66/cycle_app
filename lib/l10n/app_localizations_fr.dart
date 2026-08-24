// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Cycle App';

  @override
  String get summaryNextPeriodToday => 'Règles attendues aujourd\'hui';

  @override
  String summaryNextPeriodIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Règles dans $days jours',
      one: 'Règles dans 1 jour',
    );
    return '$_temp0';
  }

  @override
  String summaryOvulationEstimated(String date) {
    return 'Ovulation estimée le $date';
  }

  @override
  String summaryFertileWindow(String start, String end) {
    return 'Fenêtre de fertilité : du $start au $end';
  }

  @override
  String get legendPeriod => 'Règles';

  @override
  String get legendPredictedPeriod => 'Règles prédites';

  @override
  String get legendFertileWindow => 'Fenêtre de fertilité';

  @override
  String get legendOvulation => 'Ovulation';

  @override
  String get addEntryTitle => 'Ajouter des règles';

  @override
  String get editEntryTitle => 'Modifier les règles';

  @override
  String get startDateLabel => 'Date de début';

  @override
  String get endDateLabel => 'Date de fin (optionnel)';

  @override
  String get endDateOngoingHint => 'Toujours en cours';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get emptyStateTitle => 'Aucune donnée pour l\'instant';

  @override
  String get emptyStateMessage =>
      'Appuie sur une date dans le calendrier pour enregistrer le début de tes prochaines règles.';

  @override
  String get errorEndBeforeStart =>
      'La date de fin doit être après la date de début.';

  @override
  String get phaseMenstrualName => 'Règles';

  @override
  String get phaseMenstrualDescription =>
      'Ton corps élimine la muqueuse utérine. L\'énergie est souvent basse.';

  @override
  String get phaseMenstrualTag1 => 'Fatigue';

  @override
  String get phaseMenstrualTag2 => 'Crampes';

  @override
  String get phaseMenstrualTag3 => 'Envie de ralentir';

  @override
  String get phaseFollicularName => 'Folliculaire';

  @override
  String get phaseFollicularDescription =>
      'Les hormones remontent, l\'énergie et la motivation augmentent progressivement.';

  @override
  String get phaseFollicularTag1 => 'Énergie croissante';

  @override
  String get phaseFollicularTag2 => 'Humeur stable';

  @override
  String get phaseFollicularTag3 => 'Créativité';

  @override
  String get phaseOvulatoryName => 'Ovulatoire';

  @override
  String get phaseOvulatoryDescription =>
      'Pic d\'œstrogènes autour de l\'ovulation : souvent le pic d\'énergie et de confiance du cycle.';

  @override
  String get phaseOvulatoryTag1 => 'Haute énergie';

  @override
  String get phaseOvulatoryTag2 => 'Confiance';

  @override
  String get phaseOvulatoryTag3 => 'Libido accrue';

  @override
  String get phaseLutealName => 'Lutéale';

  @override
  String get phaseLutealDescription =>
      'La progestérone augmente puis chute : le syndrome prémenstruel peut apparaître en fin de phase.';

  @override
  String get phaseLutealTag1 => 'Sautes d\'humeur';

  @override
  String get phaseLutealTag2 => 'Ballonnements';

  @override
  String get phaseLutealTag3 => 'Besoin de calme';

  @override
  String get expectedFeelingsLabel => 'Ressentis typiques';

  @override
  String get howDoYouFeelButton => 'Comment tu te sens aujourd\'hui ?';

  @override
  String get symptomSheetTitle => 'Comment tu te sens aujourd\'hui ?';

  @override
  String get symptomNoteLabel => 'Note (optionnel)';

  @override
  String get symptomCramps => 'Crampes';

  @override
  String get symptomFatigue => 'Fatigue';

  @override
  String get symptomMoodSwings => 'Sautes d\'humeur';

  @override
  String get symptomHeadache => 'Maux de tête';

  @override
  String get symptomBloating => 'Ballonnements';

  @override
  String get symptomTenderBreasts => 'Seins sensibles';

  @override
  String get symptomIncreasedEnergy => 'Regain d\'énergie';

  @override
  String get symptomBackPain => 'Douleurs dorsales';

  @override
  String get symptomNausea => 'Nausées';

  @override
  String get symptomFoodCravings => 'Envies alimentaires';

  @override
  String get symptomAnxiety => 'Anxiété';

  @override
  String get symptomAcne => 'Acné';

  @override
  String get historyOpenTooltip => 'Historique des cycles';

  @override
  String get historyScreenTitle => 'Historique des cycles';

  @override
  String historyCycleLengthLabel(int days) {
    return 'Durée du cycle : $days jours';
  }

  @override
  String historyPeriodLengthLabel(int days) {
    return 'Durée des règles : $days jours';
  }

  @override
  String get historyOngoingLabel => 'En cours';

  @override
  String get historyNoSymptomsLabel => 'Aucun symptôme noté';

  @override
  String get historyEmptyTitle => 'Aucun cycle enregistré';

  @override
  String get historyEmptyMessage =>
      'Ajoute des règles depuis le calendrier pour voir ton historique ici.';

  @override
  String get profileOpenTooltip => 'Profil';

  @override
  String get profileScreenTitle => 'Profil';

  @override
  String get profileNameLabel => 'Nom';

  @override
  String get profileAgeLabel => 'Âge';

  @override
  String get profileWeightLabel => 'Poids (lb)';

  @override
  String get profileSavedMessage => 'Profil enregistré';
}
