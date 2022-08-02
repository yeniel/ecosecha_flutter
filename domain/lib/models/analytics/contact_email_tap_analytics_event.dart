import 'package:domain/domain.dart';

class ContactEmailTapAnalyticsEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.contactEmailTap;

  @override
  Map<String, dynamic> get properties => {};
}