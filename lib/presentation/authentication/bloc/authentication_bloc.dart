import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/repositories/auth/auth_service.dart';
import 'package:ecosecha_flutter/data/repositories/repository.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthService authService, required Repository repository})
      : _authService = authService,
        _repository = repository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);

    _authenticationStatusSubscription = _authService.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthService _authService;
  final Repository _repository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authService.dispose();
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
        return emit(
            user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authService.logout();
  }

  Future<User?> _tryGetUser() async {
    try {
      await _repository.fetchAll();

      var user = _repository.user;

      return user;
    } catch (_) {
      return null;
    }
  }
}
