import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';

class AccountDetailTile extends StatelessWidget {
  const AccountDetailTile({super.key, required this.detail, this.onDelete});

  final AccountingSeatDetail detail;
  final SlidableActionCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            icon: Icons.delete_outlined,
            backgroundColor: const Color(0xFFDC3545),
            foregroundColor: Colors.white,
            label: localizations.delete,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ],
      ),
      child: ListTile(
        title: Text(detail.account.name),
        trailing: Text(
          double.parse(detail.debit) > 0.0
              ? '${localizations.debit}\n${detail.debit}'
              : '${localizations.credit}\n${detail.credit}',
        ),
      ),
    );
  }
}
