import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';

abstract class IAccountingSeatDetailRepository {
  const IAccountingSeatDetailRepository();

  Future<List<AccountingSeatDetail>> findBySeatId(String uid, String seatId);
}
