import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc({
    required CompanyRepository companyRepository,
    required AnalyticsManager analyticsManager,
  })  : _companyRepository = companyRepository,
        _analyticsManager = analyticsManager,
        super(const ContactState()) {
    on<ContactInitEvent>(_onContactInitEvent);
    on<ContactPhoneTapEvent>(_onContactPhoneTapEvent);
    on<ContactEmailTapEvent>(_onContactEmailTapEvent);
  }

  final CompanyRepository _companyRepository;
  final AnalyticsManager _analyticsManager;

  void _onContactInitEvent(ContactInitEvent event, Emitter<ContactState> emit) {
    var company = _companyRepository.company;

    if (company != null) {
      emit(state.copyWith(company: company));
    }

    _analyticsManager.logEvent(ContactPageEvent());
  }

  void _onContactPhoneTapEvent(ContactPhoneTapEvent event, Emitter<ContactState> emit) {
    _analyticsManager.logEvent(ContactPhoneTapAnalyticsEvent());
  }

  void _onContactEmailTapEvent(ContactEmailTapEvent event, Emitter<ContactState> emit) {
    _analyticsManager.logEvent(ContactEmailTapAnalyticsEvent());
  }
}
