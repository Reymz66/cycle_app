import 'package:cycle_app/app.dart';
import 'package:cycle_app/features/cycle/data/cycle_entry_model.dart';
import 'package:cycle_app/features/cycle/data/cycle_repository.dart';
import 'package:cycle_app/features/cycle/presentation/providers/cycle_providers.dart';
import 'package:cycle_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_calendar/table_calendar.dart';

class _FakeCycleRepository implements CycleRepository {
  @override
  Future<void> delete(String id) async {}

  @override
  Future<void> upsert(CycleEntry entry) async {}

  @override
  List<CycleEntry> getAllSortedByStartDate() => [];
}

void main() {
  testWidgets('shows the empty state and legend on first launch',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cycleRepositoryProvider.overrideWithValue(_FakeCycleRepository()),
        ],
        child: const CycleApp(),
      ),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(TableCalendar));
    final loc = AppLocalizations.of(context)!;

    expect(find.text(loc.emptyStateTitle), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
