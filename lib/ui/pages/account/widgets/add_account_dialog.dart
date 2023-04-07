import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';
import 'package:simple_accounting/ui/pages/account/cubits/account_cubit.dart';

class AddAccountDialog extends StatelessWidget {
  const AddAccountDialog({super.key, this.account});

  final FinancialAccount? account;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final AccountCubit cubit = context.watch<AccountCubit>();
    if (account != null) {
      context.read<AccountCubit>().changeTypeForAdd(account!.accountType);
    }
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
            _InputData(
              localizations: localizations,
              account: account,
            ),
            if (account != null) const SizedBox(height: 8.0),
            if (account != null)
              CheckboxListTile(
                value: cubit.state.accountActive,
                onChanged: (value) {
                  context.read<AccountCubit>().changeActive(active: value);
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  cubit.state.accountActive
                      ? localizations.active
                      : localizations.inactive,
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: cubit.state.loading
                  ? null
                  : () async {
                      final String? error = account == null
                          ? await context.read<AccountCubit>().addAccount()
                          : await context
                              .read<AccountCubit>()
                              .updateAccount(account!.id ?? '');
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
              icon: account == null
                  ? const Icon(Icons.add_outlined)
                  : const Icon(Icons.update_outlined),
              label: Text(
                account == null ? localizations.add : localizations.edit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputData extends StatefulWidget {
  const _InputData({
    required this.localizations,
    this.account,
  });

  final AppLocalizations localizations;
  final FinancialAccount? account;

  @override
  State<_InputData> createState() => _InputDataState();
}

class _InputDataState extends State<_InputData> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    codeController.text = widget.account?.code ?? '';
    nameController.text = widget.account?.name ?? '';
    context.read<AccountCubit>().accountCode = widget.account?.code ?? '';
    context.read<AccountCubit>().accountName = widget.account?.name ?? '';
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: codeController,
          decoration: InputDecoration(
            labelText: widget.localizations.code,
          ),
          onChanged: (value) {
            context.read<AccountCubit>().accountCode = value;
          },
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: widget.localizations.name,
          ),
          onChanged: (value) {
            context.read<AccountCubit>().accountName = value;
          },
        ),
      ],
    );
  }
}
