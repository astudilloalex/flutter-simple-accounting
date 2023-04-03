import 'package:simple_accounting/src/auth/domain/auth.dart';

class Home {
  const Home({
    this.auth = const Auth(uid: ''),
    this.currentTab = 0,
  });

  final Auth auth;
  final int currentTab;

  Home copyWith({
    Auth? auth,
    int? currentTab,
  }) {
    return Home(
      auth: auth ?? this.auth,
      currentTab: currentTab ?? this.currentTab,
    );
  }
}
