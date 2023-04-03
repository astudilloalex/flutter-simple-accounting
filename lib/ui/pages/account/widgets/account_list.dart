import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/ui/pages/account/cubits/account_cubit.dart';

class AccountList extends StatelessWidget {
  const AccountList({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountCubit cubit = context.watch<AccountCubit>();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            trailing: Text(cubit.state.accounts[index].code),
            title: Text(cubit.state.accounts[index].name),
          );
        },
        childCount: cubit.state.accounts.length,
      ),
    );
  }
}
