part of 'authentication_bloc.dart';

enum AuthenticationStatus { initial, loading, error, success }

extension AuthenticationStatusX on AuthenticationStatus {
  bool get isInitial => this == AuthenticationStatus.initial;
  bool get isLoading => this == AuthenticationStatus.loading;
  bool get isError => this == AuthenticationStatus.error;
  bool get isSuccess => this == AuthenticationStatus.success;
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final bool passwordVisiable;
  const AuthenticationState(
      {this.status = AuthenticationStatus.initial, this.passwordVisiable = false});
  AuthenticationState copyWith(
          {AuthenticationStatus? status, passwordVisiable}) =>
      AuthenticationState(
          status: status ?? this.status,
          passwordVisiable: passwordVisiable ?? this.passwordVisiable);

  @override
  List<Object?> get props => [status, passwordVisiable];
}
