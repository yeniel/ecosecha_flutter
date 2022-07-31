import 'package:domain/domain.dart';

class LoginAnalyticsEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.login;

  @override
  Map<String, dynamic> get properties => {};
}