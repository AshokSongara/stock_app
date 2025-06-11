import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_repository.dart';
import '../../services/session_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

// States
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authRepository;
  final SessionRepository sessionRepository;

  AuthenticationBloc({
    required this.authRepository,
    required this.sessionRepository,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationCheckRequested>(_onAuthenticationCheckRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationLoginRequested>(_onAuthenticationLoginRequested);
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        if (event.user != null) {
          emit(AuthenticationSuccess(event.user!));
        }
        break;
      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationFailure('User is not authenticated'));
        break;
      case AuthenticationStatus.unknown:
        emit(AuthenticationInitial());
        break;
    }
  }

  Future<void> _onAuthenticationCheckRequested(
    AuthenticationCheckRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final session = sessionRepository.getSession();
      if (session != null) {
        final user = await authRepository.getCurrentUser();
        if (user != null) {
          emit(AuthenticationSuccess(user));
          return;
        }
      }
      emit(const AuthenticationFailure('No active session'));
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await authRepository.logOut();
      await sessionRepository.clearSession();
      emit(AuthenticationInitial());
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onAuthenticationLoginRequested(
    AuthenticationLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      final user = await authRepository.logIn(
        email: event.email,
        password: event.password,
      );
      await sessionRepository.saveSession(event.email);
      emit(AuthenticationSuccess(user));
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
}