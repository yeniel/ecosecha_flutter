import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'personal_data_event.dart';

part 'personal_data_state.dart';

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc({required Repository repository})
      : _repository = repository,
        super(const PersonalDataState()) {
    on<PersonalDataInitEvent>(_onPersonalDataInitEvent);
  }

  final Repository _repository;

  void _onPersonalDataInitEvent(PersonalDataInitEvent event, Emitter<PersonalDataState> emit) {
    var user = _repository.user;

    if (user != null) {
      emit(state.copyWith(user: user));
    }
  }
}
