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
    final formzStatus = Formz.validate([state.password, username]);
    final loginStatus = _mapFormzStatusToLoginStatus(formzStatus);

    emit(state.copyWith(
      username: username,
      status: loginStatus,
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    final formzStatus = Formz.validate([password, state.username]);
    final loginStatus = _mapFormzStatusToLoginStatus(formzStatus);

    emit(state.copyWith(
      password: password,
      status: loginStatus,
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final formzStatus = FormzStatus.values[state.status.index];

    if (formzStatus.isValidated) {
      var loginStatus = _mapFormzStatusToLoginStatus(FormzStatus.submissionInProgress);
      AnalyticsEvent event;

      emit(state.copyWith(status: loginStatus));

      try {
        await _authRepository.login(
          username: state.username.value,
          password: state.password.value,
        );

        loginStatus = _mapFormzStatusToLoginStatus(FormzStatus.submissionSuccess);
        event = LoginAnalyticsEvent();
      } catch (error) {
        if (error is InvalidCredentials) {
          loginStatus = LoginStatus.submissionFailureInvalidCredentials;
        } else if (error is ApiError) {
          loginStatus = LoginStatus.submissionFailure;
        } else {
          loginStatus = _mapFormzStatusToLoginStatus(FormzStatus.invalid);
        }

        event = LoginErrorEvent(error: error.toString());
      }

      emit(state.copyWith(status: loginStatus));
      _analyticsManager.logEvent(event);
    }
  }

  LoginStatus _mapFormzStatusToLoginStatus(FormzStatus formzStatus) {
    switch (formzStatus) {
      case FormzStatus.pure:
        return LoginStatus.pure;
      case FormzStatus.valid:
        return LoginStatus.valid;
      case FormzStatus.invalid:
        return LoginStatus.invalid;
      case FormzStatus.submissionInProgress:
        return LoginStatus.submissionSuccess;
      case FormzStatus.submissionFailure:
        return LoginStatus.submissionFailure;
      case FormzStatus.submissionCanceled:
        return LoginStatus.submissionCanceled;
      default:
        return LoginStatus.pure;
    }
  }
}
