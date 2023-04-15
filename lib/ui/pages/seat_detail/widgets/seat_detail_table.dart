import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:simple_accounting/ui/pages/seat_detail/cubits/seat_detail_cubit.dart';

class SeatDetailTable extends StatelessWidget {
  const SeatDetailTable({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            horizontalMargin: 10.0,
            columnSpacing: 10.0,
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(15.0),
            ),
            columns: [
              DataColumn(
                label: Text(localizations.accounts),
              ),
              DataColumn(
                label: Text(localizations.debit),
              ),
              DataColumn(
                label: Text(localizations.credit),
              ),
            ],
            rows: context
                .watch<SeatDetailCubit>()
                .state
                .details
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(
                        Text(e.account.name),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            e.debit == '0.0'
                                ? ''
                                : NumberFormat('#,##0.00').format(
                                    Decimal.parse(e.debit).toDouble(),
                                  ),
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            e.credit == '0.0'
                                ? ''
                                : NumberFormat('#,##0.00').format(
                                    Decimal.parse(e.credit).toDouble(),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
