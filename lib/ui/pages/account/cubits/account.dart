import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';

class Account {
  const Account({
    this.filterAccountType = AccountTypeEnum.assets,
    this.typeForAdd = AccountTypeEnum.assets,
    this.accountActive = true,
    this.accounts = const [],
    this.loading = true,
  });

  final AccountTypeEnum filterAccountType;
  final AccountTypeEnum typeForAdd;
  final bool accountActive;
  final List<FinancialAccount> accounts;
  final bool loading;

  Account copyWith({
    bool? accountActive,
    AccountTypeEnum? filterAccountType,
    AccountTypeEnum? typeForAdd,
    List<FinancialAccount>? accounts,
    bool? loading,
  }) {
    return Account(
      accountActive: accountActive ?? this.accountActive,
      filterAccountType: filterAccountType ?? this.filterAccountType,
      typeForAdd: typeForAdd ?? this.typeForAdd,
      accounts: accounts ?? this.accounts,
      loading: loading ?? this.loading,
    );
  }
}
