import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required Repository repository, required AuthRepository authRepository})
      : _repository = repository,
        _authRepository = authRepository,
        super(const AccountState()) {
    on<AccountInfoRequestedEvent>(_onAccountInfoRequestedEvent);
    on<AccountLogoutEvent>(_onAccountLogoutEvent);
  }

  final Repository _repository;
  final AuthRepository _authRepository;

  void _onAccountInfoRequestedEvent(AccountInfoRequestedEvent event, Emitter<AccountState> emit) {
    var user = _repository.user;
    var orderHistory = _repository.orderHistory;

    if (user != null && orderHistory != null) {
      emit(state.copyWith(user: user, orderHistory: orderHistory));
    }
  }

  void _onAccountLogoutEvent(AccountLogoutEvent event, Emitter<AccountState> emit) {
    _authRepository.logout();
  }
}
