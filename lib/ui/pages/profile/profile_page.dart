import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/ui/pages/profile/cubits/profile_cubit.dart';
import 'package:simple_accounting/ui/pages/profile/widgets/profile_option_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCubit cubit = context.watch<ProfileCubit>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const UserAvatar(),
              Text(cubit.state.auth.displayName ?? ''),
              const Expanded(
                child: ProfileOptionList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
