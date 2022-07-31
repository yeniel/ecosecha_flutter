import 'package:domain/domain.dart';

class ContactPhoneTapEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.contactPhoneTap;

  @override
  Map<String, dynamic> get properties => {};
}