import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../data/cycle_entry_model.dart';
import '../../domain/cycle_calculator.dart';

enum DayCategory { period, ovulation, fertileWindow, predictedPeriod, none }

DayCategory categorizeDay(
  DateTime day,
  List<CycleEntry> entries,
  CyclePrediction? prediction,
) {
  final date = dateOnly(day);

  bool inRange(DateTime start, DateTime end) =>
      !date.isBefore(start) && !date.isAfter(end);

  for (final entry in entries) {
    final start = dateOnly(entry.startDate);
    final end = entry.endDate == null ? start : dateOnly(entry.endDate!);
    if (inRange(start, end)) return DayCategory.period;
  }

  if (prediction != null) {
    final ovulation = dateOnly(prediction.ovulationDate);
    if (date == ovulation) return DayCategory.ovulation;

    if (inRange(prediction.fertileWindowStart, prediction.fertileWindowEnd)) {
      return DayCategory.fertileWindow;
    }

    final predictedEnd = prediction.nextPeriodStart
        .add(Duration(days: prediction.averagePeriodLength - 1));
    if (inRange(prediction.nextPeriodStart, predictedEnd)) {
      return DayCategory.predictedPeriod;
    }
  }

  return DayCategory.none;
}

class CycleCalendar extends StatefulWidget {
  const CycleCalendar({
    super.key,
    required this.entries,
    required this.prediction,
    required this.onDaySelected,
  });

  final List<CycleEntry> entries;
  final CyclePrediction? prediction;
  final void Function(DateTime day) onDaySelected;

  @override
  State<CycleCalendar> createState() => _CycleCalendarState();
}

class _CycleCalendarState extends State<CycleCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        widget.onDaySelected(selectedDay);
      },
      onPageChanged: (focusedDay) => _focusedDay = focusedDay,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) =>
            _buildDayCell(context, day),
        todayBuilder: (context, day, focusedDay) =>
            _buildDayCell(context, day, isToday: true),
        selectedBuilder: (context, day, focusedDay) =>
            _buildDayCell(context, day, isSelected: true),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }

  Widget _buildDayCell(BuildContext context, DateTime day,
      {bool isToday = false, bool isSelected = false}) {
    final category = categorizeDay(day, widget.entries, widget.prediction);
    final Color? backgroundColor = switch (category) {
      DayCategory.period => AppTheme.periodColor,
      DayCategory.ovulation => AppTheme.ovulationColor,
      DayCategory.fertileWindow => AppTheme.fertileWindowColor,
      DayCategory.predictedPeriod => AppTheme.predictedPeriodColor,
      DayCategory.none => null,
    };
    final bool useLightText = category == DayCategory.period ||
        category == DayCategory.ovulation ||
        category == DayCategory.fertileWindow;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: isToday || isSelected
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: isSelected ? 2 : 1,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: useLightText ? Colors.white : null,
          fontWeight: isToday ? FontWeight.bold : null,
        ),
      ),
    );
  }
}
