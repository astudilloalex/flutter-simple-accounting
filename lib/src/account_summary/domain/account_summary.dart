class AccountSummary {
  const AccountSummary({
    this.credit = '0.0',
    this.debit = '0.0',
    this.id,
  });

  final String credit;
  final String debit;
  final String? id;

  AccountSummary copyWith({
    String? credit,
    String? debit,
    String? id,
  }) {
    return AccountSummary(
      credit: credit ?? this.credit,
      debit: debit ?? this.debit,
      id: id ?? this.id,
    );
  }

  factory AccountSummary.fromJson(Map<String, dynamic> json) {
    return AccountSummary(
      credit: json['credit'] as String,
      debit: json['debit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'credit': credit,
      'debit': debit,
    };
  }
}
