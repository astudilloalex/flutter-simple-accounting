import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat_repository.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';

class FirestoreAccountingSeatRepository implements IAccountingSeatRepository {
  const FirestoreAccountingSeatRepository();

  @override
  Future<AccountingSeat> save(AccountingSeat entity, String uid) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    // Save the seat.
    final DocumentReference<Map<String, dynamic>> seatDoc =
        _collection(uid).doc();
    final AccountingSeat saved = AccountingSeat(
      date: entity.date,
      description: entity.description,
      id: seatDoc.id,
      total: entity.total,
      type: entity.type,
    );
    batch.set(seatDoc, saved.toJson());
    // Save the details
    final List<AccountingSeatDetail> details = [];
    for (final AccountingSeatDetail element in entity.accountDetails) {
      final DocumentReference<Map<String, dynamic>> detailDoc =
          _detailCollection(uid).doc();
      final AccountingSeatDetail detailSaved = AccountingSeatDetail(
        account: element.account,
        credit: element.credit,
        debit: element.debit,
        id: detailDoc.id,
        seat: saved,
      );
      batch.set(detailDoc, detailSaved.toJson());
      details.add(detailSaved);
    }
    await batch.commit();
    return saved.copyWith(accountDetails: details);
  }

  @override
  Future<AccountingSeat> update(AccountingSeat entity, String uid) {
    // TODO: implement update
    throw UnimplementedError();
  }

  CollectionReference<Map<String, dynamic>> _collection(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('accountseats');
  }

  CollectionReference<Map<String, dynamic>> _detailCollection(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('accountseatdetails');
  }
}
