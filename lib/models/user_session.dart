import 'package:hive/hive.dart';

part 'user_session.g.dart';

@HiveType(typeId: 0)
class UserSession extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final DateTime lastLoginTime;

  UserSession({
    required this.email,
    required this.lastLoginTime,
  });
} 