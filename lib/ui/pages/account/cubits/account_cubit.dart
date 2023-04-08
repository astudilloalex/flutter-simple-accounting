import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/financial_account/application/financial_account_service.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';
import 'package:simple_accounting/ui/pages/account/cubits/account.dart';

class AccountCubit extends Cubit<Account> {
  AccountCubit() : super(const Account());

  final FinancialAccountService _service = getIt<FinancialAccountService>();

  String accountCode = '';
  String accountName = '';

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    try {
      final List<FinancialAccount> accounts =
          await _service.getByType(state.filterAccountType);
      emit(
        state.copyWith(
          accounts: accounts,
          loading: false,
        ),
      );
    } on Exception {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> changeAccountType(AccountTypeEnum type) async {
    if (state.filterAccountType == type) return;
    emit(state.copyWith(loading: true));
    try {
      final List<FinancialAccount> accounts = await _service.getByType(type);
      emit(
        state.copyWith(
          accounts: accounts,
          filterAccountType: type,
          loading: false,
        ),
      );
    } on Exception {
      emit(state.copyWith(loading: false));
    }
  }

  void changeTypeForAdd(AccountTypeEnum? type) {
    if (type == null) return;
    emit(state.copyWith(typeForAdd: type));
  }

  Future<String?> deleteAccount(String? id) async {
    try {
      emit(state.copyWith(loading: true));
      await _service.delete(id ?? '');
      state.accounts.removeWhere((element) => element.id == id);
      emit(state.copyWith(accounts: state.accounts));
    } on Exception catch (e) {
      return e.toString();
    } finally {
      emit(state.copyWith(loading: false));
    }
    return null;
  }

  Future<String?> updateAccount(String? id) async {
    if (id == null) return null;
    final FinancialAccount account = FinancialAccount(
      active: state.accountActive,
      id: id,
      code: accountCode,
      name: accountName,
      accountType: state.typeForAdd,
    );
    try {
      emit(state.copyWith(loading: true));
      await _service.update(account);
      if (state.typeForAdd == state.filterAccountType) {
        final int index = state.accounts.indexWhere((acc) => acc.id == id);
        if (index >= 0) {
          state.accounts[index] = account;
          emit(state.copyWith(accounts: state.accounts));
        }
      }
    } on Exception catch (e) {
      return e.toString();
    } finally {
      emit(state.copyWith(loading: false));
    }
    return null;
  }

  Future<String?> addAccount() async {
    try {
      emit(state.copyWith(loading: true));
      final FinancialAccount account = await _service.add(
        FinancialAccount(
          code: accountCode,
          name: accountName,
          accountType: state.typeForAdd,
        ),
      );
      if (state.typeForAdd == state.filterAccountType) {
        state.accounts.add(account);
        emit(state.copyWith(accounts: state.accounts));
      }
    } on Exception catch (e) {
      return e.toString();
    } finally {
      emit(state.copyWith(loading: false));
    }
    return null;
  }

  void changeActive({bool? active}) {
    if (active == null) return;
    emit(state.copyWith(accountActive: active));
  }
}
