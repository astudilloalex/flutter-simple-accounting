import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:simple_accounting/ui/pages/seat_detail/cubits/seat_detail_cubit.dart';
import 'package:simple_accounting/ui/pages/seat_detail/widgets/seat_detail_table.dart';

class SeatDetailList extends StatelessWidget {
  const SeatDetailList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SeatDetailTable(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            context.watch<SeatDetailCubit>().state.details.isEmpty
                ? ''
                : context
                        .watch<SeatDetailCubit>()
                        .state
                        .details
                        .first
                        .seat
                        ?.description ??
                    '',
            textAlign: TextAlign.justify,
          ),
        ),
        const Divider(
          color: Colors.black,
          endIndent: 10.0,
          indent: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.total,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                context.watch<SeatDetailCubit>().state.details.isEmpty
                    ? ''
                    : NumberFormat('#,##0.00').format(
                        Decimal.parse(
                          context
                                  .watch<SeatDetailCubit>()
                                  .state
                                  .details
                                  .first
                                  .seat
                                  ?.total ??
                              '0.0',
                        ).toDouble(),
                      ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
