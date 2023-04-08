import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';

class AccountFooter extends StatelessWidget {
  const AccountFooter({super.key, required this.details, this.onSave});

  final List<AccountingSeatDetail> details;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    Decimal totalCredit = Decimal.zero;
    Decimal totalDebit = Decimal.zero;
    for (final AccountingSeatDetail detail in details) {
      totalCredit += Decimal.parse(detail.credit);
      totalDebit += Decimal.parse(detail.debit);
    }
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${localizations.debit}\n',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: '${totalDebit.toDouble()}'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${localizations.credit}\n',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: '${totalCredit.toDouble()}'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        ElevatedButton.icon(
          onPressed: totalDebit.compareTo(totalCredit) == 0 ? onSave : null,
          label: Text(localizations.save),
          icon: const Icon(Icons.save_outlined),
        ),
      ],
    );
  }
}
