import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required AuthRepository authRepository,
    required CompanyRepository companyRepository,
    required AnalyticsManager analyticsManager,
  })  : _authRepository = authRepository,
        _companyRepository = companyRepository,
        _analyticsManager = analyticsManager,
        super(const AccountState()) {
    on<AccountInitEvent>(_onAccountInitEvent);
    on<AccountOrderWebSiteTapEvent>(_onAccountOrderWebSiteTapEvent);
    on<AccountBlogTapEvent>(_onAccountBlogTapEvent);
    on<AccountLogoutEvent>(_onAccountLogoutEvent);
  }

  final AuthRepository _authRepository;
  final CompanyRepository _companyRepository;
  final AnalyticsManager _analyticsManager;

  void _onAccountInitEvent(AccountInitEvent event, Emitter<AccountState> emit) {
    var company = _companyRepository.company;

    if (company != null) {
      emit(state.copyWith(ordersWebUrl: company.ordersWebUrl, blogUrl: company.blogUrl));
    }
  }

  void _onAccountOrderWebSiteTapEvent(AccountOrderWebSiteTapEvent event, Emitter<AccountState> emit) {
    _analyticsManager.logEvent(OrderWebSiteTapEvent());
  }

  void _onAccountBlogTapEvent(AccountBlogTapEvent event, Emitter<AccountState> emit) {
    _analyticsManager.logEvent(BlogTapEvent());
  }

  void _onAccountLogoutEvent(AccountLogoutEvent event, Emitter<AccountState> emit) {
    _authRepository.logout();
    _analyticsManager.logEvent(LogoutEvent());
  }
}
