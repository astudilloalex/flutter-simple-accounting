import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountingSeatPage extends StatefulWidget {
  const AccountingSeatPage({super.key});

  @override
  State<AccountingSeatPage> createState() => _AccountingSeatPageState();
}

class _AccountingSeatPageState extends State<AccountingSeatPage> {
  final List<TextEditingController> controllers = [];

  @override
  void dispose() {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.accounts),
      ),
    );
  }
}
