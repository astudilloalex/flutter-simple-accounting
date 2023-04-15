import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/accounting_seat/application/accounting_seat_service.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/src/financial_account/application/financial_account_service.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit()
      : super(
          DetailState(
            endDate: DateTime.now(),
            startDate: DateTime(DateTime.now().year, DateTime.now().month),
          ),
        );

  final FinancialAccountService _service = getIt<FinancialAccountService>();
  final AccountingSeatService _seatService = getIt<AccountingSeatService>();

  Future<void> load({AccountTypeEnum type = AccountTypeEnum.assets}) async {
    final List<FinancialAccount> accounts = [];
    try {
      emit(state.copyWith(loading: true));
      accounts.addAll(await _service.getByType(type));
      await changeDates(
        DateTimeRange(start: state.startDate, end: state.endDate),
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
          accounts: accounts,
        ),
      );
    }
  }

  Future<void> changeDates(DateTimeRange range) async {
    final List<AccountingSeat> seats = [];
    try {
      emit(state.copyWith(loading: true));
      seats.addAll(
        await _seatService.getByDate(
          startDate: range.start,
          endDate: range.end,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          startDate: range.start,
          endDate: range.end,
          loading: false,
          seats: seats,
        ),
      );
    }
  }
}

/// The detail state.
class DetailState {
  const DetailState({
    this.accounts = const [],
    required this.endDate,
    this.loading = false,
    this.seats = const [],
    required this.startDate,
  });

  final List<FinancialAccount> accounts;
  final DateTime endDate;
  final bool loading;
  final List<AccountingSeat> seats;
  final DateTime startDate;

  DetailState copyWith({
    List<FinancialAccount>? accounts,
    DateTime? endDate,
    bool? loading,
    List<AccountingSeat>? seats,
    DateTime? startDate,
  }) {
    return DetailState(
      accounts: accounts ?? this.accounts,
      endDate: endDate ?? this.endDate,
      loading: loading ?? this.loading,
      seats: seats ?? this.seats,
      startDate: startDate ?? this.startDate,
    );
  }
}
