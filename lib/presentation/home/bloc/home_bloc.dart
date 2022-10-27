import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _userRepository = userRepository,
        _analyticsManager = analyticsManager,
        super(HomeInitial()) {
    on<HomeSetTabEvent>(_onHomeSetTab);

    var user = _userRepository.user;
    var isAnonymousLogin = Prefs.getBool(Prefs.anonymousLogin) ?? false;

    if (user != null && !isAnonymousLogin) {
      _analyticsManager.setUserId(user.id.toString());
    }
  }

  final UserRepository _userRepository;
  final AnalyticsManager _analyticsManager;

  Future<void> _onHomeSetTab(HomeSetTabEvent event, Emitter<HomeState> emit) async {
    emit(HomeTabSetState(tab: event.tab));

    switch (event.tab) {
      case HomeTab.order:
        _analyticsManager.logEvent(OrderPageEvent());
        break;
      case HomeTab.baskets:
        _analyticsManager.logEvent(BasketsPageEvent());
        break;
      case HomeTab.products:
        _analyticsManager.logEvent(CategoriesPageEvent());
        break;
      case HomeTab.account:
        _analyticsManager.logEvent(AccountPageEvent());
        break;
    }
  }
}
