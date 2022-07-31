import 'package:domain/domain.dart';

class LogoutEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.logout;

  @override
  Map<String, dynamic> get properties => {};
}