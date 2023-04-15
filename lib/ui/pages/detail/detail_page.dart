import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/ui/pages/detail/cubits/detail_cubit.dart';
import 'package:simple_accounting/ui/pages/detail/widgets/detail_seat_dates.dart';
import 'package:simple_accounting/ui/pages/detail/widgets/detail_seat_list.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.details),
      ),
      body: Column(
        children: [
          const DetailSeatDates(),
          Expanded(
            child: context.watch<DetailCubit>().state.seats.isNotEmpty
                ? const DetailSeatList()
                : context.watch<DetailCubit>().state.loading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Center(
                        child: Text(AppLocalizations.of(context)!.noResults),
                      ),
          ),
        ],
      ),
    );
  }
}
