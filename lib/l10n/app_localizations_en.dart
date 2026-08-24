// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Cycle App';

  @override
  String get summaryNextPeriodToday => 'Period expected today';

  @override
  String summaryNextPeriodIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Period in $days days',
      one: 'Period in 1 day',
    );
    return '$_temp0';
  }

  @override
  String summaryOvulationEstimated(String date) {
    return 'Ovulation estimated on $date';
  }

  @override
  String summaryFertileWindow(String start, String end) {
    return 'Fertile window: $start to $end';
  }

  @override
  String get legendPeriod => 'Period';

  @override
  String get legendPredictedPeriod => 'Predicted period';

  @override
  String get legendFertileWindow => 'Fertile window';

  @override
  String get legendOvulation => 'Ovulation';

  @override
  String get addEntryTitle => 'Add period';

  @override
  String get editEntryTitle => 'Edit period';

  @override
  String get startDateLabel => 'Start date';

  @override
  String get endDateLabel => 'End date (optional)';

  @override
  String get endDateOngoingHint => 'Still ongoing';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get deleteButton => 'Delete';

  @override
  String get emptyStateTitle => 'No data yet';

  @override
  String get emptyStateMessage =>
      'Tap a date on the calendar to log the start of your next period.';

  @override
  String get errorEndBeforeStart =>
      'The end date must be after the start date.';
}
