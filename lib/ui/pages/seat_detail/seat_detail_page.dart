import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_accounting/ui/pages/seat_detail/cubits/seat_detail_cubit.dart';
import 'package:simple_accounting/ui/pages/seat_detail/widgets/seat_detail_list.dart';

class SeatDetailPage extends StatelessWidget {
  const SeatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.watch<SeatDetailCubit>().state.details.isEmpty
            ? null
            : Text(
                DateFormat('EEE, MMM dd, yyyy HH:mm').format(
                  context
                          .watch<SeatDetailCubit>()
                          .state
                          .details
                          .first
                          .seat
                          ?.date ??
                      DateTime.now(),
                ),
              ),
      ),
      body: const SeatDetailList(),
    );
  }
}
