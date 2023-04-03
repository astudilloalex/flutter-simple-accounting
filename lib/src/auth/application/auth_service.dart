import 'package:simple_accounting/src/auth/domain/auth.dart';
import 'package:simple_accounting/src/auth/domain/auth_repository.dart';

class AuthService {
  const AuthService(this._repository);

  final IAuthRepository _repository;

  Future<Auth?> get currentAuth => _repository.currentAuth;

  Future<Auth?> signInWithGoogle() => _repository.signInWithGoogle();

  Future<void> logout() => _repository.logout();
}
