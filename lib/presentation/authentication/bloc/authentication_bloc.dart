import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthRepository authRepository,
    required Repository repository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _repository = repository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);

    _authenticationStatusSubscription = _authRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthRepository _authRepository;
  final Repository _repository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();

        if (user != null) {
          return emit(AuthenticationState.authenticated(user));
        } else {
          return emit(const AuthenticationState.unauthenticated());
        }
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authRepository.logout();
  }

  Future<User?> _tryGetUser() async {
    await _repository.fetchAll().catchError((error) async {
      if (error is ExpiredToken) {
        await _authRepository.renewToken();
        await _repository.fetchAll();
      }
    });

    return _userRepository.user;
  }
}
