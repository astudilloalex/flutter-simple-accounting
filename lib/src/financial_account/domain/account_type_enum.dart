enum AccountTypeEnum implements Comparable<AccountTypeEnum> {
  assets(id: 1, name: 'assets'),
  liabilities(id: 2, name: 'liabilities'),
  patrimony(id: 3, name: 'patrimony'),
  incomes(id: 4, name: 'incomes'),
  expenses(id: 5, name: 'expenses');

  const AccountTypeEnum({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  int compareTo(AccountTypeEnum other) => id - other.id;
}
