part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class ContactInitEvent extends ContactEvent {
  const ContactInitEvent();

  @override
  List<Object?> get props => [];
}

class ContactPhoneTapEvent extends ContactEvent {
  const ContactPhoneTapEvent();

  @override
  List<Object?> get props => [];
}

class ContactEmailTapEvent extends ContactEvent {
  const ContactEmailTapEvent();

  @override
  List<Object?> get props => [];
}

class AddressTapEvent extends ContactEvent {
  const AddressTapEvent();

  @override
  List<Object?> get props => [];
}
