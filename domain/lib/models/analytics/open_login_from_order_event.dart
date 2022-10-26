import 'package:domain/domain.dart';

class OpenLoginFromOrderEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.openLoginFromOrder;

  @override
  Map<String, dynamic> get properties => {};
}