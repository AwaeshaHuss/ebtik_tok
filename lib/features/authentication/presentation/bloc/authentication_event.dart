part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent{
  final String? phone;
  final String? password;
  const LoginEvent({required this.phone, required this.password});
}

class ToggelPasswordVisibilityEvent extends AuthenticationEvent{}