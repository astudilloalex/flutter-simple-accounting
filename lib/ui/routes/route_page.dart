import 'package:go_router/go_router.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/auth/application/auth_service.dart';
import 'package:simple_accounting/ui/pages/home/home_page.dart';
import 'package:simple_accounting/ui/pages/sign_in/sign_in_page.dart';
import 'package:simple_accounting/ui/routes/route_name.dart';

class RoutePage {
  const RoutePage._();
  static final GoRouter router = GoRouter(
    initialLocation: RouteName.home,
    redirect: (context, state) async {
      if ((await getIt<AuthService>().currentAuth) == null) {
        return RouteName.signIn;
      }
      return null;
    },
    routes: [
      GoRoute(
        name: RouteName.home,
        path: RouteName.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: RouteName.signIn,
        path: RouteName.signIn,
        builder: (context, state) => const SignInPage(),
      ),
    ],
  );
}
