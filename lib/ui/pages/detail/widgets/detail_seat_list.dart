import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/ui/pages/detail/cubits/detail_cubit.dart';
import 'package:simple_accounting/ui/routes/route_name.dart';

class DetailSeatList extends StatelessWidget {
  const DetailSeatList({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailCubit cubit = context.watch<DetailCubit>();
    return ListView.builder(
      itemCount: cubit.state.seats.length,
      itemBuilder: (context, index) {
        final AccountingSeat seat = cubit.state.seats[index];
        return Card(
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EEE, MMM dd, yyyy HH:mm').format(seat.date),
                ),
                Text(
                  NumberFormat('#,##0.00').format(
                    Decimal.parse(seat.total).toDouble(),
                  ),
                ),
              ],
            ),
            subtitle: seat.description != null ? Text(seat.description!) : null,
            //trailing: Icon(Icons.adaptive.arrow_forward_outlined),
            onTap: () {
              context.pushNamed(
                RouteName.seatDetail,
                params: {
                  'id': seat.id ?? '',
                },
              );
            },
          ),
        );
      },
    );
  }
}
