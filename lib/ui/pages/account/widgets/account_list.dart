import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';
import 'package:simple_accounting/ui/pages/account/cubits/account_cubit.dart';
import 'package:simple_accounting/ui/pages/account/widgets/add_account_dialog.dart';

class AccountList extends StatelessWidget {
  const AccountList({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountCubit cubit = context.watch<AccountCubit>();
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    if (cubit.state.loading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                // SlidableAction(
                //   onPressed: (_) => _deleteAccount(
                //     context,
                //     cubit.state.accounts[index],
                //   ),
                //   icon: Icons.delete_outlined,
                //   backgroundColor: const Color(0xFFDC3545),
                //   foregroundColor: Colors.white,
                //   label: localizations.delete,
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
                SlidableAction(
                  onPressed: (_) => _edit(
                    context,
                    cubit.state.accounts[index],
                  ),
                  icon: Icons.edit_outlined,
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  label: localizations.edit,
                )
              ],
            ),
            child: Card(
              child: ListTile(
                leading: cubit.state.accounts[index].active
                    ? const Icon(
                        Icons.check_outlined,
                        color: Color(0xFF00FF00),
                      )
                    : const Icon(
                        Icons.remove_outlined,
                        color: Color(0xFF808080),
                      ),
                trailing: Text(cubit.state.accounts[index].code),
                title: Text(cubit.state.accounts[index].name),
              ),
            ),
          );
        },
        childCount: cubit.state.accounts.length,
      ),
    );
  }

  void _edit(BuildContext context, FinancialAccount account) {
    context.read<AccountCubit>().changeActive(active: account.active);
    showDialog(
      context: context,
      builder: (context) => AddAccountDialog(
        account: account,
      ),
    );
  }

  // void _deleteAccount(BuildContext context, FinancialAccount account) {
  //   final AppLocalizations localizations = AppLocalizations.of(context)!;
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(localizations.delete),
  //         content: Text(localizations.areYouSureToDelete),
  //         actions: [
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: const Color(0xFF778899),
  //               foregroundColor: Colors.white,
  //             ),
  //             onPressed: context.pop,
  //             child: Text(localizations.no),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               context.read<AccountCubit>().deleteAccount(account.id);
  //               context.pop();
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: const Color(0xFFDC143C),
  //               foregroundColor: Colors.white,
  //             ),
  //             child: Text(localizations.yes),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
