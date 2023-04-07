import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account_repository.dart';

class FirestoreFinancialAccountRepository
    implements IFinancialAccountRepository {
  const FirestoreFinancialAccountRepository();

  @override
  Future<void> delete(String id, String uid) {
    return _collection(uid).doc(id).delete();
  }

  @override
  Future<List<FinancialAccount>> findAll(String uid) {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<List<FinancialAccount>> findByType(AccountTypeEnum type, String uid) {
    return _collection(uid)
        .where('accountType', isEqualTo: type.id)
        .get()
        .then((value) {
      return value.docs
          .map((e) => FinancialAccount.fromJson(e.data(), e.id))
          .toList();
    });
  }

  @override
  Future<FinancialAccount> save(FinancialAccount entity, String uid) async {
    final DocumentReference<Map<String, dynamic>> doc =
        await _collection(uid).add(entity.toJson());
    return entity.copyWith(id: doc.id);
  }

  @override
  Future<FinancialAccount> update(FinancialAccount entity, String uid) async {
    await _collection(uid).doc(entity.id).update(entity.toJson());
    return entity;
  }

  CollectionReference<Map<String, dynamic>> _collection(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('accounts');
  }
}
