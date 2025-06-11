import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';
import 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  final UserModel? user;

  const AuthenticationStatusChanged(this.status, this.user);

  @override
  List<Object?> get props => [status, user];
}

class AuthenticationCheckRequested extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
} 