import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';

class FinancialAccount {
  const FinancialAccount({
    this.active = true,
    required this.code,
    this.id,
    required this.name,
    required this.accountType,
  });

  final bool active;
  final String code;
  final String? id;
  final String name;
  final AccountTypeEnum accountType;

  FinancialAccount copyWith({
    bool? active,
    String? code,
    String? id,
    String? name,
    AccountTypeEnum? accountType,
  }) {
    return FinancialAccount(
      active: active ?? this.active,
      code: code ?? this.code,
      id: id ?? this.id,
      name: name ?? this.name,
      accountType: accountType ?? this.accountType,
    );
  }

  factory FinancialAccount.fromJson(Map<String, dynamic> json) {
    final AccountTypeEnum type = AccountTypeEnum.values.firstWhere(
      (element) => (json['accountType'] as int) == element.id,
    );
    return FinancialAccount(
      active: (json['active'] as bool?) ?? true,
      accountType: type,
      code: json['code'] as String,
      id: json['id'] as String?,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'code': code,
      'id': id,
      'name': name,
      'accountType': accountType.id,
    };
  }
}
