import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 2)
class UserProfile extends HiveObject {
  UserProfile({
    required this.name,
    this.age,
    this.weightLbs,
    this.partnerPhoneNumber,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final int? age;

  @HiveField(2)
  final double? weightLbs;

  @HiveField(3)
  final String? partnerPhoneNumber;
}
