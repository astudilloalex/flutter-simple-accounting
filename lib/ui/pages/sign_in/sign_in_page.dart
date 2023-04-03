import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_accounting/ui/routes/route_name.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          context.goNamed(RouteName.home);
        }),
        AuthStateChangeAction<UserCreated>((context, state) {
          context.goNamed(RouteName.home);
        })
      ],
    );
  }
}
