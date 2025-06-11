import 'package:hive_flutter/hive_flutter.dart';

import '../models/user_session.dart';

class SessionRepository {
  static const String _boxName = 'sessionBox';
  static const String _sessionKey = 'userSession';

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserSessionAdapter());
    }
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<UserSession>(_boxName);
    }
  }

  Future<void> saveSession(String email) async {
    final box = Hive.box<UserSession>(_boxName);
    final session = UserSession(
      email: email,
      lastLoginTime: DateTime.now(),
    );
    await box.put(_sessionKey, session);
  }

  Future<void> clearSession() async {
    final box = Hive.box<UserSession>(_boxName);
    await box.delete(_sessionKey);
  }

  UserSession? getSession() {
    final box = Hive.box<UserSession>(_boxName);
    return box.get(_sessionKey);
  }

  bool hasActiveSession() {
    return getSession() != null;
  }
} 