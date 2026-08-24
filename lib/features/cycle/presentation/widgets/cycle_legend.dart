import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class CycleLegend extends StatelessWidget {
  const CycleLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          _LegendItem(color: AppTheme.periodColor, label: loc.legendPeriod),
          _LegendItem(
            color: AppTheme.predictedPeriodColor,
            label: loc.legendPredictedPeriod,
          ),
          _LegendItem(
            color: AppTheme.fertileWindowColor,
            label: loc.legendFertileWindow,
          ),
          _LegendItem(
            color: AppTheme.ovulationColor,
            label: loc.legendOvulation,
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
