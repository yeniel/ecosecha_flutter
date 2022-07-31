import 'package:domain/domain.dart';

class LoginEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.login;

  late String user;

  @override
  Map<String, dynamic> get properties => {'user': user};
}