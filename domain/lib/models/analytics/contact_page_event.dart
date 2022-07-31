import 'package:domain/domain.dart';

class ContactPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.contactPage;

  @override
  Map<String, dynamic> get properties => {};
}