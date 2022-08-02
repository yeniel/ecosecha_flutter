part of 'contact_bloc.dart';

class ContactState extends Equatable {
  const ContactState({this.company = Company.empty});

  final Company company;

  ContactState copyWith({required Company company}) {
    return ContactState(company: company);
  }

  @override
  List<Object> get props => [company];
}
