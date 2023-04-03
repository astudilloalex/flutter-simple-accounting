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
    final List<FinancialAccount> accounts =
        await _service.getByType(state.filterAccountType);
    emit(
      state.copyWith(
        accounts: accounts,
      ),
    );
  }

  Future<void> changeAccountType(AccountTypeEnum type) async {
    if (state.filterAccountType == type) return;
    final List<FinancialAccount> accounts = await _service.getByType(type);
    emit(
      state.copyWith(
        accounts: accounts,
        filterAccountType: type,
      ),
    );
  }

  void changeTypeForAdd(AccountTypeEnum? type) {
    if (type == null) return;
    emit(state.copyWith(typeForAdd: type));
  }

  Future<String?> addAccount() async {
    try {
      final FinancialAccount account = FinancialAccount(
        code: accountCode,
        name: accountName,
        accountType: state.typeForAdd,
      );
      await _service.add(account);
      if (state.typeForAdd == state.filterAccountType) {
        state.accounts.add(account);
        emit(state.copyWith(accounts: state.accounts));
      }
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }
}
