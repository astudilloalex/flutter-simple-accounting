import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail_repository.dart';

class FirestoreSeatDetailRepository implements IAccountingSeatDetailRepository {
  const FirestoreSeatDetailRepository();

  @override
  Future<List<AccountingSeatDetail>> findBySeatId(String uid, String seatId) {
    return _collection(uid)
        .where('seatId', isEqualTo: seatId)
        .get()
        .then((value) {
      return value.docs
          .map((e) => AccountingSeatDetail.fromJson(e.data()))
          .toList();
    });
  }

  CollectionReference<Map<String, dynamic>> _collection(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('accountseatdetails');
  }
}
