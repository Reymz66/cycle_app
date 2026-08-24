import 'package:hive_flutter/hive_flutter.dart';

import 'user_profile_model.dart';

class UserProfileRepository {
  UserProfileRepository(this._box);

  static const boxName = 'user_profile';
  static const _key = 'profile';

  final Box<UserProfile> _box;

  static Future<UserProfileRepository> open() async {
    final box = await Hive.openBox<UserProfile>(boxName);
    return UserProfileRepository(box);
  }

  UserProfile? get() => _box.get(_key);

  Future<void> save(UserProfile profile) => _box.put(_key, profile);
}
