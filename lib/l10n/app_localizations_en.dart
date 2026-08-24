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

  @override
  String get phaseMenstrualName => 'Menstrual';

  @override
  String get phaseMenstrualDescription =>
      'Your body sheds the uterine lining. Energy is often low.';

  @override
  String get phaseMenstrualTag1 => 'Fatigue';

  @override
  String get phaseMenstrualTag2 => 'Cramps';

  @override
  String get phaseMenstrualTag3 => 'Craving rest';

  @override
  String get phaseFollicularName => 'Follicular';

  @override
  String get phaseFollicularDescription =>
      'Hormones rise again, energy and motivation gradually increase.';

  @override
  String get phaseFollicularTag1 => 'Rising energy';

  @override
  String get phaseFollicularTag2 => 'Stable mood';

  @override
  String get phaseFollicularTag3 => 'Creativity';

  @override
  String get phaseOvulatoryName => 'Ovulatory';

  @override
  String get phaseOvulatoryDescription =>
      'Estrogen peaks around ovulation — often the energy and confidence peak of the cycle.';

  @override
  String get phaseOvulatoryTag1 => 'High energy';

  @override
  String get phaseOvulatoryTag2 => 'Confidence';

  @override
  String get phaseOvulatoryTag3 => 'Increased libido';

  @override
  String get phaseLutealName => 'Luteal';

  @override
  String get phaseLutealDescription =>
      'Progesterone rises then drops: PMS can appear late in this phase.';

  @override
  String get phaseLutealTag1 => 'Mood swings';

  @override
  String get phaseLutealTag2 => 'Bloating';

  @override
  String get phaseLutealTag3 => 'Need for calm';

  @override
  String get expectedFeelingsLabel => 'Typical feelings';

  @override
  String get howDoYouFeelButton => 'How are you feeling today?';

  @override
  String get symptomSheetTitle => 'How are you feeling today?';

  @override
  String get symptomNoteLabel => 'Note (optional)';

  @override
  String get symptomCramps => 'Cramps';

  @override
  String get symptomFatigue => 'Fatigue';

  @override
  String get symptomMoodSwings => 'Mood swings';

  @override
  String get symptomHeadache => 'Headache';

  @override
  String get symptomBloating => 'Bloating';

  @override
  String get symptomTenderBreasts => 'Tender breasts';

  @override
  String get symptomIncreasedEnergy => 'Increased energy';

  @override
  String get symptomBackPain => 'Back pain';

  @override
  String get symptomNausea => 'Nausea';

  @override
  String get symptomFoodCravings => 'Food cravings';

  @override
  String get symptomAnxiety => 'Anxiety';

  @override
  String get symptomAcne => 'Acne';

  @override
  String get historyOpenTooltip => 'Cycle history';

  @override
  String get historyScreenTitle => 'Cycle history';

  @override
  String historyCycleLengthLabel(int days) {
    return 'Cycle length: $days days';
  }

  @override
  String historyPeriodLengthLabel(int days) {
    return 'Period length: $days days';
  }

  @override
  String get historyOngoingLabel => 'Ongoing';

  @override
  String get historyNoSymptomsLabel => 'No symptoms logged';

  @override
  String get historyEmptyTitle => 'No cycles logged yet';

  @override
  String get historyEmptyMessage =>
      'Add a period from the calendar to see your history here.';

  @override
  String get profileOpenTooltip => 'Profile';

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String get profileNameLabel => 'Name';

  @override
  String get profileAgeLabel => 'Age';

  @override
  String get profileWeightLabel => 'Weight (lbs)';

  @override
  String get profilePartnerPhoneLabel => 'Partner\'s phone number';

  @override
  String get profileSavedMessage => 'Profile saved';

  @override
  String get notifyPartnerButton => 'Notify my partner';

  @override
  String get notifyPartnerMissingNumber =>
      'Add your partner\'s phone number in your profile first.';

  @override
  String partnerMessageTemplate(String phase) {
    return 'Hey, I\'m in my $phase phase today.';
  }
}
