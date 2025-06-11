import 'dart:async';
import '../models/user_model.dart';
import '../services/session_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  UserModel? _user;
  final SessionRepository _sessionRepository;

  AuthenticationRepository({SessionRepository? sessionRepository})
      : _sessionRepository = sessionRepository ?? SessionRepository();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Simulate successful login
    _user = UserModel(
      id: '1',
      name: 'Test User',
      email: email,
      bio: 'Test user account',
    );
    _controller.add(AuthenticationStatus.authenticated);
    return _user!;
  }

  Future<UserModel?> getCurrentUser() async {
    if (_user == null) {
      // Try to restore user from session
      final session = _sessionRepository.getSession();
      if (session != null) {
        _user = UserModel(
          id: '1',
          name: 'Test User',
          email: session.email,
          bio: 'Test user account',
        );
        _controller.add(AuthenticationStatus.authenticated);
      }
    }
    return _user;
  }

  Future<void> updateUser(UserModel user) async {
    if (user.name.isEmpty) {
      throw Exception('Name cannot be empty');
    }
    if (user.email.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(user.email)) {
      throw Exception('Invalid email address');
    }

    try {
      // Simulate API call
      await Future.delayed(
        const Duration(milliseconds: 500),
        () {
          _user = user;
          _controller.add(AuthenticationStatus.authenticated);
        },
      );
    } catch (error) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception('Update user failed: ${error.toString()}');
    }
  }

  Future<void> logOut() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
