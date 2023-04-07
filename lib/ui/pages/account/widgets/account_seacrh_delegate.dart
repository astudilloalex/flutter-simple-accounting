import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';
import 'package:simple_accounting/ui/pages/account/widgets/add_account_dialog.dart';

class AccountSearchDelegate extends SearchDelegate<FinancialAccount?> {
  AccountSearchDelegate(this.accounts);

  final List<FinancialAccount> accounts;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.adaptive.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final List<FinancialAccount> finded = accounts.where((element) {
      return element.code.toLowerCase().contains(query.toLowerCase()) ||
          element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: finded.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _edit(
                  context,
                  finded[index],
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
              trailing: Text(finded[index].code),
              title: Text(finded[index].name),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final List<FinancialAccount> finded = accounts.where((element) {
      return element.code.toLowerCase().contains(query.toLowerCase()) ||
          element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: finded.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _edit(
                  context,
                  finded[index],
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
              trailing: Text(finded[index].code),
              title: Text(finded[index].name),
            ),
          ),
        );
      },
    );
  }

  void _edit(BuildContext context, FinancialAccount account) {
    showDialog(
      context: context,
      builder: (context) => AddAccountDialog(
        account: account,
      ),
    );
  }
}
