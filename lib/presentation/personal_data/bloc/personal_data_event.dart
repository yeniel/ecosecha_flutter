part of 'personal_data_bloc.dart';

abstract class PersonalDataEvent extends Equatable {
  const PersonalDataEvent();
}

class PersonalDataRequestedEvent extends PersonalDataEvent {
  const PersonalDataRequestedEvent();

  @override
  List<Object?> get props => [];
}
