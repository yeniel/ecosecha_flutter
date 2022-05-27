part of 'personal_data_bloc.dart';

abstract class PersonalDataState extends Equatable {
  const PersonalDataState();
}

class PersonalDataInitial extends PersonalDataState {
  @override
  List<Object> get props => [];
}
