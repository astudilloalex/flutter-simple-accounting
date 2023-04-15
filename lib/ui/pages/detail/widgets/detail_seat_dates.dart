import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_accounting/ui/pages/detail/cubits/detail_cubit.dart';

class DetailSeatDates extends StatelessWidget {
  const DetailSeatDates({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: context.watch<DetailCubit>().state.loading
          ? null
          : () {
              final DateTime now = DateTime.now();
              showDateRangePicker(
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                context: context,
                firstDate: now.add(-const Duration(days: 30 * 6)),
                lastDate: now.add(const Duration(days: 30 * 6)),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.blue,
                      ),
                    ),
                    child: child!,
                  );
                },
              ).then((value) {
                if (value == null) return;
                context.read<DetailCubit>().changeDates(value);
              });
            },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(
                context.watch<DetailCubit>().state.startDate,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 12.0,
              ),
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(
                context.watch<DetailCubit>().state.endDate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
