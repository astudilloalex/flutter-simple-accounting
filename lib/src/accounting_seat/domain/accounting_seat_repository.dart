import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';

abstract class IAccountingSeatRepository {
  const IAccountingSeatRepository();

  Future<List<AccountingSeat>> findByDates(
    String uid, {
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<AccountingSeat> save(AccountingSeat entity, String uid);
  Future<AccountingSeat> update(AccountingSeat entity, String uid);
}
