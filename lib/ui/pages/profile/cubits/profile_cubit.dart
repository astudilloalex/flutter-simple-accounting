import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/auth/application/auth_service.dart';
import 'package:simple_accounting/src/auth/domain/auth.dart';
import 'package:simple_accounting/ui/pages/profile/cubits/profile.dart';

class ProfileCubit extends Cubit<Profile> {
  ProfileCubit() : super(const Profile());

  final AuthService _authService = getIt<AuthService>();

  Future<void> load() async {
    final Auth? auth = await _authService.currentAuth;
    emit(state.copyWith(auth: auth));
  }

  Future<String?> logout() async {
    try {
      await _authService.logout();
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }
}
