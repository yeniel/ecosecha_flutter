part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class ContactInitEvent extends ContactEvent {
  const ContactInitEvent();

  @override
  List<Object?> get props => [];
}