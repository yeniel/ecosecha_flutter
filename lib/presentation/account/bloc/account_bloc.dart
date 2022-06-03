import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required AuthRepository authRepository, required CompanyRepository companyRepository})
      : _authRepository = authRepository, _companyRepository = companyRepository,
        super(const AccountState()) {
    on<AccountInitEvent>(_onAccountInitEvent);
    on<AccountLogoutEvent>(_onAccountLogoutEvent);
  }

  final AuthRepository _authRepository;
  final CompanyRepository _companyRepository;

  void _onAccountInitEvent(AccountInitEvent event, Emitter<AccountState> emit) {
    var company = _companyRepository.company;

    if (company != null) {
      emit(state.copyWith(ordersWebUrl: company.ordersWebUrl, blogUrl: company.blogUrl));
    }
  }

  // void _onAccountInfoInitEvent(AccountInfoInitEvent event, Emitter<AccountState> emit) {
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
