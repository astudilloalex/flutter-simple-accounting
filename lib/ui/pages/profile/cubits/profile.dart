import 'package:simple_accounting/src/auth/domain/auth.dart';

class Profile {
  const Profile({
    this.auth = const Auth(uid: ''),
  });

  final Auth auth;

  Profile copyWith({
    Auth? auth,
  }) {
    return Profile(
      auth: auth ?? this.auth,
    );
  }
}
