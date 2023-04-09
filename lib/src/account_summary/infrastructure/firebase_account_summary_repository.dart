import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_accounting/src/account_summary/domain/account_summary.dart';
import 'package:simple_accounting/src/account_summary/domain/account_summary_repository.dart';

class FirebaseAccountSummaryRepository implements IAccountSummaryRepository {
  const FirebaseAccountSummaryRepository();

  @override
  Stream<List<AccountSummary>> findAllStream(String uid) {
    return _collection(uid).snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => AccountSummary.fromJson(doc.data()).copyWith(id: doc.id),
          )
          .toList();
    });
  }

  CollectionReference<Map<String, dynamic>> _collection(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('accountsummary');
  }
}
