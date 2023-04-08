import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';

class AccountingSeatDetail {
  const AccountingSeatDetail({
    required this.account,
    this.credit = '0.0',
    this.debit = '0.0',
    this.id,
    this.seat,
  });

  final FinancialAccount account;
  final String credit;
  final String debit;
  final String? id;
  final AccountingSeat? seat;

  AccountingSeatDetail copyWith({
    FinancialAccount? account,
    String? credit,
    String? debit,
    String? id,
    AccountingSeat? seat,
  }) {
    return AccountingSeatDetail(
      account: account ?? this.account,
      credit: credit ?? this.credit,
      debit: debit ?? this.debit,
      id: id ?? this.id,
      seat: seat ?? this.seat,
    );
  }

  factory AccountingSeatDetail.fromJson(Map<String, dynamic> json) {
    return AccountingSeatDetail(
      account: FinancialAccount.fromJson(
        json['account'] as Map<String, dynamic>,
      ),
      credit: json['credit'] as String,
      debit: json['debit'] as String,
      id: json['id'] as String?,
      seat: AccountingSeat.fromJson(json['seat'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account': account.toJson(),
      'accountId': account.id,
      'credit': credit,
      'debit': debit,
      'id': id,
      'seat': seat?.toJson(),
      'seatId': seat?.id,
    };
  }
}
