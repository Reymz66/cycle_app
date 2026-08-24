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
}
