import 'package:domain/domain.dart';

class ContactPhoneTapAnalyticsEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.contactPhoneTap;

  @override
  Map<String, dynamic> get properties => {};
}