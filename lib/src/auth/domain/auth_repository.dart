import 'package:simple_accounting/src/auth/domain/auth.dart';

abstract class IAuthRepository {
  const IAuthRepository();

  Future<Auth?> get currentAuth;
  Future<void> logout();
  Future<Auth?> signInWithGoogle();
  Future<Auth?> signUpWithEmailAndPassword(String email, String password);
}
