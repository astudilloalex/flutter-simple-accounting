import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/auth/application/auth_service.dart';
import 'package:simple_accounting/src/auth/domain/auth.dart';
import 'package:simple_accounting/ui/pages/home/home.dart';

class HomeCubit extends Cubit<Home> {
  HomeCubit() : super(const Home());
  final AuthService _authService = getIt<AuthService>();

  Future<void> load() async {
    final Auth? auth = await _authService.currentAuth;
    emit(state.copyWith(auth: auth));
  }

  void changeTab(int index) => emit(state.copyWith(currentTab: index));
}
