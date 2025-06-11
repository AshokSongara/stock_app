import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final UserModel user;

  const AuthenticationSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure(this.message);

  @override
  List<Object?> get props => [message];
} 