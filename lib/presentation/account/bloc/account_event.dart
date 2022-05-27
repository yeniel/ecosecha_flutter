part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class AccountInfoRequestedEvent extends AccountEvent {
  const AccountInfoRequestedEvent();

  @override
  List<Object?> get props => [];
}

class AccountLogoutEvent extends AccountEvent {
  const AccountLogoutEvent();

  @override
  List<Object?> get props => [];
}
