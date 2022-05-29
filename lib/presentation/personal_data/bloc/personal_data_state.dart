part of 'personal_data_bloc.dart';

class PersonalDataState extends Equatable {
  const PersonalDataState({this.user = User.empty});

  final User user;

  PersonalDataState copyWith({required User user}) {
    return PersonalDataState(user: user);
  }
  @override
  List<Object> get props => [user];
}
