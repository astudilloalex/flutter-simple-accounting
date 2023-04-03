import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/ui/pages/account/cubits/account_cubit.dart';

class AddAccountDialog extends StatelessWidget {
  const AddAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final AccountCubit cubit = context.watch<AccountCubit>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<AccountTypeEnum>(
              value: cubit.state.typeForAdd,
              items: [
                DropdownMenuItem(
                  value: AccountTypeEnum.assets,
                  child: Text(localizations.assets),
                ),
                DropdownMenuItem(
                  value: AccountTypeEnum.liabilities,
                  child: Text(localizations.liabilities),
                ),
                DropdownMenuItem(
                  value: AccountTypeEnum.patrimony,
                  child: Text(localizations.patrimony),
                ),
                DropdownMenuItem(
                  value: AccountTypeEnum.incomes,
                  child: Text(localizations.incomes),
                ),
                DropdownMenuItem(
                  value: AccountTypeEnum.expenses,
                  child: Text(localizations.expenses),
                ),
              ],
              onChanged: context.read<AccountCubit>().changeTypeForAdd,
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.code,
              ),
              onChanged: (value) {
                context.read<AccountCubit>().accountCode = value;
              },
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.name,
              ),
              onChanged: (value) {
                context.read<AccountCubit>().accountName = value;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () async {
                final String? error =
                    await context.read<AccountCubit>().addAccount();
                if (context.mounted) {
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                      ),
                    );
                  } else {
                    context.pop();
                  }
                }
              },
              icon: const Icon(Icons.add_outlined),
              label: Text(localizations.add),
            ),
          ],
        ),
      ),
    );
  }
}
