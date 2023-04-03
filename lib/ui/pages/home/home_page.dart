import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/ui/pages/account/account_page.dart';
import 'package:simple_accounting/ui/pages/dashboard/dashboard_page.dart';
import 'package:simple_accounting/ui/pages/detail/detail_page.dart';
import 'package:simple_accounting/ui/pages/home/cubits/home_cubit.dart';
import 'package:simple_accounting/ui/pages/profile/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    const List<Widget> tabs = [
      DashboardPage(),
      DetailPage(),
      AccountPage(),
      ProfilePage(),
    ];
    final HomeCubit cubit = context.watch<HomeCubit>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     cubit.state.currentTab == 0
      //         ? localizations.dashboard
      //         : cubit.state.currentTab == 1
      //             ? localizations.details
      //             : localizations.accounts,
      //   ),
      //   centerTitle: true,
      //   leading: CircleAvatar(
      //     backgroundImage: NetworkImage(
      //       cubit.state.auth.photoURL ??
      //           'https://i.postimg.cc/WzCPwS95/user-circular-avatar.png',
      //     ),
      //   ),
      //   leadingWidth: 40.0,
      // ),
      body: tabs[cubit.state.currentTab],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add_outlined),
      // ),
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
