import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';

class FinancialAccount {
  const FinancialAccount({
    required this.code,
    required this.name,
    required this.accountType,
  });

  final String code;
  final String name;
  final AccountTypeEnum accountType;

  factory FinancialAccount.fromJson(Map<String, dynamic> json) {
    final AccountTypeEnum type = AccountTypeEnum.values.firstWhere(
      (element) => (json['accountType'] as int) == element.id,
    );
    return FinancialAccount(
      accountType: type,
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'accountType': accountType.id,
    };
  }
}
