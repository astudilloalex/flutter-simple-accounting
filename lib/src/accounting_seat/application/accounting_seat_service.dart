import 'package:decimal/decimal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat_repository.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';

class AccountingSeatService {
  const AccountingSeatService(this._repository);

  final IAccountingSeatRepository _repository;

  Future<AccountingSeat> add(AccountingSeat accountingSeat) async {
    Decimal total = Decimal.zero;
    for (final AccountingSeatDetail element in accountingSeat.accountDetails) {
      total += Decimal.parse(element.debit);
    }
    return _repository.save(
      accountingSeat.copyWith(total: '${total.toDouble()}'),
      FirebaseAuth.instance.currentUser?.uid ?? '',
    );
  }

  Future<List<AccountingSeat>> getByDate({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _repository.findByDates(
      FirebaseAuth.instance.currentUser?.uid ?? '',
      startDate: startDate,
      endDate: endDate,
    );
  }
}
