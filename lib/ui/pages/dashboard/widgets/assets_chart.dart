import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/app/app.dart';
import 'package:simple_accounting/src/account_summary/domain/account_summary.dart';

class AssetsChart extends StatelessWidget {
  const AssetsChart({
    super.key,
    required this.summary,
    this.title = '',
    this.backgroundColor = const Color(0xFF008000),
  });

  final AccountSummary summary;
  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final double credit = double.parse(summary.credit);
    final double debit = double.parse(summary.debit);
    final double maxY = credit > debit ? credit : debit;
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: credit,
                            width: 25.0,
                            color: Colors.white,
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              color: Colors.white.darken().withOpacity(0.3),
                              toY: maxY,
                            ),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: debit,
                            width: 25.0,
                            color: Colors.white,
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              color: Colors.white.darken().withOpacity(0.3),
                              toY: maxY,
                            ),
                          ),
                        ],
                      ),
                    ],
                    borderData: FlBorderData(
                      show: false,
                    ),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 38.0,
                          getTitlesWidget: (value, meta) {
                            if (value == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  localizations.credit,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                localizations.debit,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
