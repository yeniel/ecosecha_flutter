import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'personal_data_event.dart';
part 'personal_data_state.dart';

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc() : super(PersonalDataInitial()) {
    on<PersonalDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
