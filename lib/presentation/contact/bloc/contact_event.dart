part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class ContactRequestedEvent extends ContactEvent {
  const ContactRequestedEvent();

  @override
  List<Object?> get props => [];
}