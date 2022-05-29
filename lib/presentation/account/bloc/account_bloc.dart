import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AccountState()) {
    on<AccountLogoutEvent>(_onAccountLogoutEvent);
  }

  final AuthRepository _authRepository;

  // void _onAccountInfoRequestedEvent(AccountInfoRequestedEvent event, Emitter<AccountState> emit) {
  //   var orderHistory = _repository.orderHistory;
  //
  //   if (orderHistory != null) {
  //     emit(state.copyWith(orderHistory: orderHistory));
  //   }
  // }

  void _onAccountLogoutEvent(AccountLogoutEvent event, Emitter<AccountState> emit) {
    _authRepository.logout();
  }
}
