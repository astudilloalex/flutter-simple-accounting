import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';

class Account {
  const Account({
    this.filterAccountType = AccountTypeEnum.assets,
    this.typeForAdd = AccountTypeEnum.assets,
    this.accounts = const [],
  });

  final AccountTypeEnum filterAccountType;
  final AccountTypeEnum typeForAdd;
  final List<FinancialAccount> accounts;

  Account copyWith({
    AccountTypeEnum? filterAccountType,
    AccountTypeEnum? typeForAdd,
    List<FinancialAccount>? accounts,
  }) {
    return Account(
      filterAccountType: filterAccountType ?? this.filterAccountType,
      typeForAdd: typeForAdd ?? this.typeForAdd,
      accounts: accounts ?? this.accounts,
    );
  }
}
