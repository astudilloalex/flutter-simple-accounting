import 'package:simple_accounting/src/user_detail/domain/user_detail.dart';

/// Repository for [UserDetail] entity.
abstract class IUserDetailRepository {
  const IUserDetailRepository();

  /// Find a user by string [uid].
  Future<UserDetail?> findById(String uid);

  /// Save a new [user].
  Future<UserDetail> save(UserDetail user);

  /// Update a [user].
  Future<UserDetail> update(UserDetail user);
}
