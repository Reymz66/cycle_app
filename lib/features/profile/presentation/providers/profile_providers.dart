import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/user_profile_model.dart';
import '../../data/user_profile_repository.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  throw UnimplementedError(
    'userProfileRepositoryProvider must be overridden in main() once the '
    'Hive box has been opened.',
  );
});

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier(this._repository) : super(_repository.get());

  final UserProfileRepository _repository;

  Future<void> save(UserProfile profile) async {
    await _repository.save(profile);
    state = profile;
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
  final repository = ref.watch(userProfileRepositoryProvider);
  return UserProfileNotifier(repository);
});
