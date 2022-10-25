import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

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
    on<AddressTapEvent>(_onAddressTapEvent);
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

  Future<void> _onContactPhoneTapEvent(ContactPhoneTapEvent event, Emitter<ContactState> emit) async {
    var phoneUri = Uri.parse('tel:${state.company.phone}');

    await launchUrl(phoneUri);
    _analyticsManager.logEvent(ContactPhoneTapAnalyticsEvent());
  }

  Future<void> _onContactEmailTapEvent(ContactEmailTapEvent event, Emitter<ContactState> emit) async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Constants.supportEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Duda o sugerencia desde la App',
        'body': 'Hola:\n\n'
      }),
    );

    await launchUrl(emailLaunchUri);
    _analyticsManager.logEvent(ContactEmailTapAnalyticsEvent());
  }

  Future<void> _onAddressTapEvent(AddressTapEvent event, Emitter<ContactState> emit) async {
    var addressUri = Uri.parse(Constants.addressUrl);

    await launchUrl(addressUri);
    _analyticsManager.logEvent(ContactAddressTapAnalyticsEvent());
  }
}
