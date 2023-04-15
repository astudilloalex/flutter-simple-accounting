import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/ui/pages/account/account_page.dart';
import 'package:simple_accounting/ui/pages/accounting_seat/accounting_seat_page.dart';
import 'package:simple_accounting/ui/pages/accounting_seat/cubits/accounting_seat_cubit.dart';
import 'package:simple_accounting/ui/pages/dashboard/dashboard_page.dart';
import 'package:simple_accounting/ui/pages/detail/cubits/detail_cubit.dart';
import 'package:simple_accounting/ui/pages/detail/detail_page.dart';
import 'package:simple_accounting/ui/pages/home/cubits/home_cubit.dart';
import 'package:simple_accounting/ui/pages/profile/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final List<Widget> tabs = [
      const DashboardPage(),
      BlocProvider<DetailCubit>(
        create: (context) => DetailCubit()..load(),
        child: const DetailPage(),
      ),
      BlocProvider(
        create: (_) => AccountingSeatCubit(),
        child: const AccountingSeatPage(),
      ),
      const AccountPage(),
      const ProfilePage(),
    ];
    final HomeCubit cubit = context.watch<HomeCubit>();
    return Scaffold(
      body: tabs[cubit.state.currentTab],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: cubit.changeTab,
        selectedIndex: cubit.state.currentTab,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            label: localizations.dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.details_outlined),
            label: localizations.details,
          ),
          NavigationDestination(
            icon: const Icon(Icons.add_circle_outlined),
            label: localizations.add,
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_balance_outlined),
            label: localizations.accounts,
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_circle_outlined),
            label: localizations.profile,
          ),
        ],
      ),
    );
  }
}
