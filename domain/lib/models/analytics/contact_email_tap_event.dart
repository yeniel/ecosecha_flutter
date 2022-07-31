import 'package:domain/domain.dart';

class ContactEmailTapEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.contactEmailTap;

  @override
  Map<String, dynamic> get properties => {};
}