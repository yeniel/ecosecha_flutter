import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation//login/login.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
    required AnalyticsManager analyticsManager,
  })  : _authRepository = authRepository,
        _analyticsManager = analyticsManager,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;
  final AnalyticsManager _analyticsManager;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        await _authRepository.login(
          username: state.username.value,
          password: state.password.value,
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        _analyticsManager.logEvent(LoginAnalyticsEvent());
      } catch (error) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        _analyticsManager.logEvent(LoginErrorEvent(error: error.toString()));
      }
    }
  }
}
