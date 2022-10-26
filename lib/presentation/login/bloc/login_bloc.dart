import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation//login/login.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:url_launcher/url_launcher.dart';

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
    on<LoginSignUp>(_onSignUp);
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

    if (formzStatus.isValidated || event.isAnonymousLogin) {
      var loginStatus = _mapFormzStatusToLoginStatus(FormzStatus.submissionInProgress);
      var username = event.isAnonymousLogin ? Constants.anonymousUsername : state.username.value;
      var password = event.isAnonymousLogin ? Constants.anonymousPassword : state.password.value;

      emit(state.copyWith(status: loginStatus, isAnonymousLogin: event.isAnonymousLogin));
      loginStatus = await _login(username: username, password: password);
      emit(state.copyWith(status: loginStatus, isAnonymousLogin: event.isAnonymousLogin));

      _sendLoginEvent(
        loginStatus: loginStatus,
        username: username,
        password: password,
        isAnonymousLogin: event.isAnonymousLogin,
      );
      await Prefs.setBool(Prefs.anonymousLogin, event.isAnonymousLogin);
    }
  }

  Future<LoginStatus> _login({required String username, required String password}) async {
    try {
      await _authRepository.login(username: username, password: password);

      return _mapFormzStatusToLoginStatus(FormzStatus.submissionSuccess);
    } catch (error) {
      if (error is InvalidCredentials) {
        return LoginStatus.submissionFailureInvalidCredentials;
      } else if (error is ApiError) {
        return LoginStatus.submissionFailure;
      } else {
        return _mapFormzStatusToLoginStatus(FormzStatus.invalid);
      }
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

  void _sendLoginEvent({
    required LoginStatus loginStatus,
    required String username,
    required String password,
    required bool isAnonymousLogin,
  }) {
    AnalyticsEvent event;

    if (loginStatus == LoginStatus.submissionSuccess) {
      event = LoginAnalyticsEvent(username: username, password: password, isAnonymousLogin: isAnonymousLogin);
    } else {
      event = LoginErrorEvent(error: loginStatus.toString());
    }

    _analyticsManager.logEvent(event);
  }

  void _onSignUp(
      LoginSignUp event,
      Emitter<LoginState> emit,
      ) async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Constants.signUpEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': Constants.signUpSubject,
        'body': Constants.signUpBody
      }),
    );

    await launchUrl(emailLaunchUri);
    _analyticsManager.logEvent(SignUpFromOrderEvent());
  }
}
