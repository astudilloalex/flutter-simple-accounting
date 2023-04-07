import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account_repository.dart';

class FinancialAccountService {
  const FinancialAccountService(this._repository);

  final IFinancialAccountRepository _repository;

  Future<FinancialAccount> add(FinancialAccount account) {
    return _repository.save(
      account,
      FirebaseAuth.instance.currentUser?.uid ?? '',
    );
  }

  Future<void> delete(String id) {
    return _repository.delete(
      id,
      FirebaseAuth.instance.currentUser?.uid ?? '',
    );
  }

  Future<List<FinancialAccount>> getByType(AccountTypeEnum type) async {
    final List<FinancialAccount> data = await _repository.findByType(
      type,
      FirebaseAuth.instance.currentUser?.uid ?? '',
    );
    data.sort(
      (a, b) => a.code.compareTo(b.code),
    );
    return data;
  }

  Future<FinancialAccount> update(FinancialAccount account) {
    return _repository.update(
      account,
      FirebaseAuth.instance.currentUser?.uid ?? '',
    );
  }
}
