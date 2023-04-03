import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/ui/pages/account/widgets/account_app_bar.dart';
import 'package:simple_accounting/ui/pages/account/widgets/account_list.dart';
import 'package:simple_accounting/ui/pages/account/widgets/add_account_dialog.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Builder(
      builder: (context) {
        return Scaffold(
          body: const SafeArea(
            child: CustomScrollView(
              slivers: [
                AccountAppBar(),
                AccountList(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const AddAccountDialog(),
              );
            },
            child: const Icon(Icons.add_outlined),
          ),
        );
      },
    );
  }
}
