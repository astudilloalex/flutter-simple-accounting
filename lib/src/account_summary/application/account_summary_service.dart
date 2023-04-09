import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_accounting/src/account_summary/domain/account_summary.dart';
import 'package:simple_accounting/src/account_summary/domain/account_summary_repository.dart';

class AccountSummaryService {
  const AccountSummaryService(this._repository);

  final IAccountSummaryRepository _repository;

  Stream<List<AccountSummary>> findAll() {
    return _repository.findAllStream(
      FirebaseAuth.instance.currentUser?.uid ?? '',
    );
  }
}
