part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isAnonymousLogin = false,
  });

  final LoginStatus status;
  final Username username;
  final Password password;
  final bool isAnonymousLogin;

  LoginState copyWith({
    LoginStatus? status,
    Username? username,
    Password? password,
    bool? isAnonymousLogin,
    Exception? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isAnonymousLogin: isAnonymousLogin ?? this.isAnonymousLogin,
    );
  }

  @override
  List<Object> get props => [status, username, password, isAnonymousLogin];
}
