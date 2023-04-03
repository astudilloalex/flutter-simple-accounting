import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/ui/pages/account/widgets/filter_account_dialog.dart';

class AccountAppBar extends StatelessWidget {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return SliverAppBar(
      floating: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(localizations.searchAccounts),
          onTap: () {},
          minLeadingWidth: 0.0,
          leading: const Icon(Icons.search_outlined),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const FilterAccountDialog(),
              );
            },
            icon: const Icon(Icons.format_list_bulleted_outlined),
          ),
        ),
      ),
    );
  }
}
