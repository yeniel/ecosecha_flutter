import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'personal_data_event.dart';
part 'personal_data_state.dart';

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc({required Repository repository}) : _repository = repository, super(const PersonalDataState()) {
    on<PersonalDataRequestedEvent>(_onPersonalDataRequestedEvent);
  }

  final Repository _repository;

  void _onPersonalDataRequestedEvent(PersonalDataRequestedEvent event, Emitter<PersonalDataState> emit) {
    var user = _repository.user;

    if (user != null) {
      emit(state.copyWith(user: user));
    }
  }

}
