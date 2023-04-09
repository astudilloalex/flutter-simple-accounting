import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/account_summary/application/account_summary_service.dart';
import 'package:simple_accounting/src/account_summary/domain/account_summary.dart';

class DashboardCubit extends Cubit<List<AccountSummary>> {
  DashboardCubit() : super([]) {
    _subscription = _service.findAll().listen((event) {
      emit(event);
    });
  }
  StreamSubscription<List<AccountSummary>>? _subscription;
  final AccountSummaryService _service = getIt<AccountSummaryService>();

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
