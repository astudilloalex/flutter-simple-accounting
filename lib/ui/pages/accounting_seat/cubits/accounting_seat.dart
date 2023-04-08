class AccountingSeatData {
  const AccountingSeatData({
    this.loading = false,
  });

  final bool loading;

  AccountingSeatData copyWith({
    bool? loading,
  }) {
    return AccountingSeatData(loading: loading ?? this.loading);
  }
}
