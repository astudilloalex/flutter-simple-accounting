import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';

abstract class IFinancialAccountRepository {
  const IFinancialAccountRepository();

  Future<void> delete(String code, String uid);
  Future<List<FinancialAccount>> findAll(String uid);
  Future<List<FinancialAccount>> findByType(AccountTypeEnum type, String uid);
  Future<FinancialAccount> save(FinancialAccount entity, String uid);
  Future<FinancialAccount> update(FinancialAccount entity, String uid);
}