enum LoginStatus {
  pure,
  valid,
  invalid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
  submissionFailureInvalidCredentials,
  submissionCanceled,
}

extension LoginStatusExt on LoginStatus {
  bool get isValidated => _validatedLoginStatuses.contains(this);
}

const _validatedLoginStatuses = <LoginStatus>{
  LoginStatus.valid,
  LoginStatus.submissionInProgress,
  LoginStatus.submissionSuccess,
  LoginStatus.submissionFailure,
  LoginStatus.submissionCanceled,
};