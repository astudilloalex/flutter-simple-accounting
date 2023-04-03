import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_accounting/src/user_detail/domain/user_detail.dart';
import 'package:simple_accounting/src/user_detail/domain/user_detail_repository.dart';

class FirebaseUserDetailRepository implements IUserDetailRepository {
  const FirebaseUserDetailRepository();

  CollectionReference<Map<String, dynamic>> get _collection {
    return FirebaseFirestore.instance.collection('users');
  }

  @override
  Future<UserDetail?> findById(String uid) {
    final DocumentReference<Map<String, dynamic>> doc = _collection.doc(uid);
    return doc.get().then((value) {
      if (!value.exists || value.data() == null) return null;
      return UserDetail.fromJson(value.data()!);
    });
  }

  @override
  Future<UserDetail> save(UserDetail user) async {
    final DocumentReference<Map<String, dynamic>> doc =
        _collection.doc(user.uid);
    final DocumentSnapshot<Map<String, dynamic>> finded = await doc.get();
    if (finded.exists && finded.data() != null) {
      return UserDetail.fromJson(finded.data()!);
    }
    await doc.set(user.toJson());
    return user;
  }

  @override
  Future<UserDetail> update(UserDetail user) async {
    final DocumentReference<Map<String, dynamic>> doc =
        _collection.doc(user.uid);
    await doc.update(user.toJson());
    return user;
  }
}
