import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/ui/pages/accounting_seat/cubits/accounting_seat_cubit.dart';
import 'package:simple_accounting/ui/pages/accounting_seat/widgets/account_detail_tile.dart';
import 'package:simple_accounting/ui/pages/accounting_seat/widgets/account_footer.dart';
import 'package:simple_accounting/ui/pages/accounting_seat/widgets/add_account_detail_dialog.dart';
import 'package:simple_accounting/ui/pages/home/cubits/home_cubit.dart';

class AccountingSeatPage extends StatefulWidget {
  const AccountingSeatPage({super.key});

  @override
  State<AccountingSeatPage> createState() => _AccountingSeatPageState();
}

class _AccountingSeatPageState extends State<AccountingSeatPage> {
  final List<AccountingSeatDetail> details = [];
  DateTime date = DateTime.now();
  AccountTypeEnum type = AccountTypeEnum.incomes;
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.addMovement),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Date information.
                  Text(
                    localizations.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        context.watch<AccountingSeatCubit>().state.loading
                            ? null
                            : () async {
                                showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(DateTime.now().year + 10),
                                ).then((dateValue) {
                                  if (dateValue != null) {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(date),
                                    ).then((value) {
                                      setState(() {
                                        date = DateTime(
                                          dateValue.year,
                                          dateValue.month,
                                          dateValue.day,
                                          value?.hour ?? date.hour,
                                          value?.minute ?? date.minute,
                                        );
                                      });
                                    });
                                  }
                                });
                              },
                    child:
                        Text(DateFormat('MMM dd, yyyy - HH:mm').format(date)),
                  ),
                  const SizedBox(height: 10.0),
                  // Movement type
                  Text(
                    localizations.movementType,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  DropdownButton<AccountTypeEnum>(
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
                    value: type,
                    onChanged:
                        context.watch<AccountingSeatCubit>().state.loading
                            ? null
                            : (value) {
                                if (value == null) return;
                                setState(() => type = value);
                              },
                  ),
                  const SizedBox(height: 10.0),
                  // Input description.
                  TextField(
                    controller: descriptionController,
                    maxLength: 300,
                    decoration: InputDecoration(
                      labelText: localizations.description,
                    ),
                    minLines: 3,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10.0),
                  // Accounts
                  Text(
                    localizations.accounts,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: context
                              .watch<AccountingSeatCubit>()
                              .state
                              .loading
                          ? null
                          : () async {
                              final AccountingSeatDetail? detail =
                                  await showDialog<AccountingSeatDetail?>(
                                context: context,
                                builder: (context) =>
                                    const AddAccountDetailDialog(),
                              );
                              if (detail != null &&
                                  details.indexWhere(
                                        (element) =>
                                            element.account.id ==
                                            detail.account.id,
                                      ) ==
                                      -1) {
                                setState(() {
                                  details.add(detail);
                                });
                              } else if (context.mounted && detail != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(localizations
                                        .accountWithSameCodeExists),
                                  ),
                                );
                              }
                            },
                      icon: const Icon(Icons.add_outlined),
                      label: Text(localizations.add),
                    ),
                  ),
                  ...details.map<AccountDetailTile>(
                    (e) => AccountDetailTile(
                      detail: e,
                      onDelete: (context) {
                        setState(() {
                          details.removeWhere(
                            (element) => element.account.code == e.account.code,
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (details.isNotEmpty)
              AccountFooter(
                details: details,
                onSave: context.watch<AccountingSeatCubit>().state.loading
                    ? null
                    : () {
                        context
                            .read<AccountingSeatCubit>()
                            .addSeat(
                              AccountingSeat(
                                date: date,
                                accountDetails: details,
                                type: type,
                                description: descriptionController.text.trim(),
                              ),
                            )
                            .then((value) {
                          context.read<HomeCubit>().changeTab(0);
                        });
                      },
              ),
          ],
        ),
      ),
    );
  }
}
