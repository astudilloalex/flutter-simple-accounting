import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';
import 'package:simple_accounting/ui/pages/accounting_seat/cubits/accounts_cubit.dart';

class AddAccountDetailDialog extends StatefulWidget {
  const AddAccountDetailDialog({super.key});

  @override
  State<AddAccountDetailDialog> createState() => _AddAccountDetailDialogState();
}

class _AddAccountDetailDialogState extends State<AddAccountDetailDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController debitController = TextEditingController();
  final TextEditingController creditController = TextEditingController();

  AccountTypeEnum accountType = AccountTypeEnum.assets;
  FinancialAccount? financialAccount;

  @override
  void initState() {
    super.initState();
    debitController.addListener(() {
      if (debitController.text.trim().isNotEmpty) {
        creditController.text = '';
        formKey.currentState?.validate();
      }
    });
    creditController.addListener(() {
      if (creditController.text.trim().isNotEmpty) {
        debitController.text = '';
        formKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    debitController.dispose();
    creditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Dialog(
      child: BlocProvider(
        create: (context) => AccountsCubit()..loadByType(accountType),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Text(
                        localizations.add,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButtonFormField<AccountTypeEnum>(
                      decoration: InputDecoration(
                        labelText: localizations.accountType,
                      ),
                      isExpanded: true,
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
                      value: accountType,
                      onChanged: (value) {
                        if (value == accountType) return;
                        context
                            .read<AccountsCubit>()
                            .loadByType(value ?? AccountTypeEnum.assets)
                            .then((_) {
                          final List<FinancialAccount> accounts =
                              context.read<AccountsCubit>().state;
                          setState(() {
                            financialAccount =
                                accounts.isEmpty ? null : accounts[0];
                            accountType = value ?? AccountTypeEnum.assets;
                          });
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButtonFormField<FinancialAccount>(
                      decoration: InputDecoration(
                        labelText: localizations.selectAnAccount,
                      ),
                      isExpanded: true,
                      items: context
                          .watch<AccountsCubit>()
                          .state
                          .map<DropdownMenuItem<FinancialAccount>>(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      value: financialAccount,
                      onChanged: (value) {
                        setState(() {
                          financialAccount = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: debitController,
                      decoration: InputDecoration(
                        labelText: localizations.debit,
                        hintText: '112.20',
                      ),
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (creditController.text.trim().isEmpty) {
                          try {
                            double.parse(value ?? '');
                          } on Exception {
                            return localizations.invalidValue;
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: creditController,
                      decoration: InputDecoration(
                        labelText: localizations.credit,
                        hintText: '112.20',
                      ),
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (debitController.text.trim().isEmpty) {
                          try {
                            double.parse(value ?? '');
                          } on Exception {
                            return localizations.invalidValue;
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _save,
                        icon: const Icon(Icons.add_outlined),
                        label: Text(localizations.add),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _save() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (financialAccount == null) {
      final AppLocalizations localizations = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.selectAnAccount,
          ),
        ),
      );
      return;
    }
    context.pop(
      AccountingSeatDetail(
        account: financialAccount!,
        credit: creditController.text.trim().isEmpty
            ? '0.0'
            : double.parse(creditController.text.trim()).toString(),
        debit: debitController.text.trim().isEmpty
            ? '0.0'
            : double.parse(debitController.text.trim()).toString(),
      ),
    );
  }
}
