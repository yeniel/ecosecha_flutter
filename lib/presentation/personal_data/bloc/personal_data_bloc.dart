import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'personal_data_event.dart';

part 'personal_data_state.dart';

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc({
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _userRepository = userRepository,
        _analyticsManager = analyticsManager,
        super(const PersonalDataState()) {
    on<PersonalDataInitEvent>(_onPersonalDataInitEvent);
  }

  final UserRepository _userRepository;
  final AnalyticsManager _analyticsManager;

  void _onPersonalDataInitEvent(PersonalDataInitEvent event, Emitter<PersonalDataState> emit) {
    var user = _userRepository.user;

    if (user != null) {
      emit(state.copyWith(user: user));
    }

    _analyticsManager.logEvent(PersonalDataPageEvent());
  }
}
