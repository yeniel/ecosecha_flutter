part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class AccountLogoutEvent extends AccountEvent {
  const AccountLogoutEvent();

  @override
  List<Object?> get props => [];
}
