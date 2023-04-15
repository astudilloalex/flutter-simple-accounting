import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail_repository.dart';

class AccountingSeatDetailService {
  const AccountingSeatDetailService(this._repository);

  final IAccountingSeatDetailRepository _repository;

  Future<List<AccountingSeatDetail>> getBySeatId(String seatId) {
    return _repository.findBySeatId(
      FirebaseAuth.instance.currentUser?.uid ?? '',
      seatId,
    );
  }
}
