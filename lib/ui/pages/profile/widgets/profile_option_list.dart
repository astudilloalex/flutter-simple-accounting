import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_accounting/ui/pages/profile/cubits/profile_cubit.dart';
import 'package:simple_accounting/ui/routes/route_name.dart';

class ProfileOptionList extends StatelessWidget {
  const ProfileOptionList({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: Text(localizations.logout),
          trailing: Icon(Icons.adaptive.arrow_forward_outlined),
          onTap: () async {
            final String? error = await context.read<ProfileCubit>().logout();
            if (context.mounted) {
              if (error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
              } else {
                context.goNamed(RouteName.signIn);
              }
            }
          },
        )
      ],
    );
  }
}
