import 'package:domain/domain.dart';

class SignUpFromOrderEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.signUpFromOrder;

  @override
  Map<String, dynamic> get properties => {};
}