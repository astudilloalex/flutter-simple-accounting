import 'package:simple_accounting/src/account_summary/domain/account_summary.dart';

abstract class IAccountSummaryRepository {
  const IAccountSummaryRepository();

  Stream<List<AccountSummary>> findAllStream(String uid);
}
