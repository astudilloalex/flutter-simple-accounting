import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/ui/pages/account/cubits/account_cubit.dart';

class FilterAccountDialog extends StatelessWidget {
  const FilterAccountDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AccountCubit cubit = context.watch<AccountCubit>();
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<AccountTypeEnum>(
            value: AccountTypeEnum.assets,
            groupValue: cubit.state.filterAccountType,
            onChanged: (value) => _changeType(context, value),
            title: Text(localizations.assets),
          ),
          RadioListTile<AccountTypeEnum>(
            value: AccountTypeEnum.liabilities,
            groupValue: cubit.state.filterAccountType,
            onChanged: (value) => _changeType(context, value),
            title: Text(localizations.liabilities),
          ),
          RadioListTile<AccountTypeEnum>(
            value: AccountTypeEnum.patrimony,
            groupValue: cubit.state.filterAccountType,
            onChanged: (value) => _changeType(context, value),
            title: Text(localizations.patrimony),
          ),
          RadioListTile<AccountTypeEnum>(
            value: AccountTypeEnum.incomes,
            groupValue: cubit.state.filterAccountType,
            onChanged: (value) => _changeType(context, value),
            title: Text(localizations.incomes),
          ),
          RadioListTile<AccountTypeEnum>(
            value: AccountTypeEnum.expenses,
            groupValue: cubit.state.filterAccountType,
            onChanged: (value) => _changeType(context, value),
            title: Text(localizations.expenses),
          ),
        ],
      ),
    );
  }

  Future<void> _changeType(BuildContext context, AccountTypeEnum? type) async {
    if (type == null) return;
    await context.read<AccountCubit>().changeAccountType(type);
    if (context.mounted) context.pop();
  }
}
