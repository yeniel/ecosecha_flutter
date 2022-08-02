import 'package:domain/domain.dart';

class PersonalDataPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.personalDataPage;

  @override
  Map<String, dynamic> get properties => {};
}