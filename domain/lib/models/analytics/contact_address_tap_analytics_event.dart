import 'package:domain/domain.dart';

class ContactAddressTapAnalyticsEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.contactEmailTap;

  @override
  Map<String, dynamic> get properties => {};
}