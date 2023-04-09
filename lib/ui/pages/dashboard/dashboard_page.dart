import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/src/account_summary/domain/account_summary.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/ui/pages/dashboard/cubits/dashboard_cubit.dart';
import 'package:simple_accounting/ui/pages/dashboard/widgets/assets_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.dashboard),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          children: [
            // Assets chart
            AssetsChart(
              summary: context.watch<DashboardCubit>().state.firstWhere(
                (element) {
                  return element.id == AccountTypeEnum.assets.name;
                },
                orElse: () => AccountSummary(id: AccountTypeEnum.assets.name),
              ),
              title: localizations.assets,
              backgroundColor: const Color(0xFF78DEC3),
            ),
            // Liabilities chart
            AssetsChart(
              summary: context.watch<DashboardCubit>().state.firstWhere(
                (element) {
                  return element.id == AccountTypeEnum.liabilities.name;
                },
                orElse: () =>
                    AccountSummary(id: AccountTypeEnum.liabilities.name),
              ),
              title: localizations.liabilities,
              backgroundColor: const Color(0xFFFFA500),
            ),
            // Patrimony chart
            AssetsChart(
              summary: context.watch<DashboardCubit>().state.firstWhere(
                (element) {
                  return element.id == AccountTypeEnum.patrimony.name;
                },
                orElse: () =>
                    AccountSummary(id: AccountTypeEnum.patrimony.name),
              ),
              title: localizations.patrimony,
              backgroundColor: const Color(0xFFCFB53B),
            ),
            // Incomes chart
            AssetsChart(
              summary: context.watch<DashboardCubit>().state.firstWhere(
                (element) {
                  return element.id == AccountTypeEnum.incomes.name;
                },
                orElse: () => AccountSummary(id: AccountTypeEnum.incomes.name),
              ),
              title: localizations.incomes,
              backgroundColor: const Color(0xFF0077B5),
            ),
            // Expenses chart
            AssetsChart(
              summary: context.watch<DashboardCubit>().state.firstWhere(
                (element) {
                  return element.id == AccountTypeEnum.expenses.name;
                },
                orElse: () => AccountSummary(id: AccountTypeEnum.expenses.name),
              ),
              title: localizations.expenses,
              backgroundColor: const Color(0xFFA9A9A9),
            ),
          ],
        ),
      ),
    );
  }
}
