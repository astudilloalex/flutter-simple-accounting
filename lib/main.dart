import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/ui/pages/account/cubits/account_cubit.dart';
import 'package:simple_accounting/ui/pages/dashboard/cubits/dashboard_cubit.dart';
import 'package:simple_accounting/ui/pages/home/cubits/home_cubit.dart';
import 'package:simple_accounting/ui/pages/profile/cubits/profile_cubit.dart';
import 'package:simple_accounting/ui/routes/route_page.dart';
import 'package:simple_accounting/ui/theme/app_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await Firebase.initializeApp();
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: ''),
  ]);
  setUpGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountCubit>(create: (context) => AccountCubit()..load()),
        BlocProvider<DashboardCubit>(create: (context) => DashboardCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()..load()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()..load()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routerConfig: RoutePage.router,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppThemeData.light,
      ),
    );
  }
}
