part of 'personal_data_bloc.dart';

abstract class PersonalDataEvent extends Equatable {
  const PersonalDataEvent();
}

class PersonalDataInitEvent extends PersonalDataEvent {
  const PersonalDataInitEvent();

  @override
  List<Object?> get props => [];
}
