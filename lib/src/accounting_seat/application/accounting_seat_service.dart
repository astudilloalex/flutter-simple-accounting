import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat_repository.dart';

class AccountingSeatService {
  const AccountingSeatService(this._repository);

  final IAccountingSeatRepository _repository;

  Future<AccountingSeat> add(AccountingSeat accountingSeat) async {
    return _repository.save(
      accountingSeat,
      FirebaseAuth.instance.currentUser?.uid ?? '',
    );
  }
}
