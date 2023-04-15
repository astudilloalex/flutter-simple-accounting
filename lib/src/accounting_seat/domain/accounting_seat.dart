import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';

class AccountingSeat {
  const AccountingSeat({
    this.accountDetails = const [],
    required this.date,
    this.description,
    this.id,
    this.total = '0.0',
    this.type = AccountTypeEnum.assets,
  });

  final List<AccountingSeatDetail> accountDetails;
  final DateTime date;
  final String? description;
  final String? id;
  final String total;
  final AccountTypeEnum type;

  AccountingSeat copyWith({
    List<AccountingSeatDetail>? accountDetails,
    DateTime? date,
    String? description,
    String? id,
    String? total,
    AccountTypeEnum? type,
  }) {
    return AccountingSeat(
      accountDetails: accountDetails ?? this.accountDetails,
      date: date ?? this.date,
      description: description ?? this.description,
      id: id ?? this.id,
      total: total ?? this.total,
      type: type ?? this.type,
    );
  }

  factory AccountingSeat.fromJson(Map<String, dynamic> json) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(
      (json['date'] as Timestamp).seconds * 1000,
    );
    final AccountTypeEnum type = AccountTypeEnum.values.firstWhere(
      (e) => e.id == json['type'] as int,
      orElse: () => AccountTypeEnum.assets,
    );
    return AccountingSeat(
      date: date,
      description: json['description'] as String?,
      id: json['id'] as String?,
      total: json['total'] as String,
      type: type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'description': description,
      'id': id,
      'total': total,
      'type': type.id,
    };
  }
}
