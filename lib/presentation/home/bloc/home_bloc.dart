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
    on<HomeSetTabEvent>((event, emit) => emit(HomeTabSetState(tab: event.tab)));

    var user = _userRepository.user;

    if (user != null) {
      _analyticsManager.setUserId(user.id.toString());
    }

    _analyticsManager.logEvent(StartAppEvent());
  }

  final UserRepository _userRepository;
  final AnalyticsManager _analyticsManager;
}
