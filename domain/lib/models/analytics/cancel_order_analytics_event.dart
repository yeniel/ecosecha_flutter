import 'package:domain/domain.dart';

class CancelOrderAnalyticsEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.cancelOrder;

  @override
  Map<String, dynamic> get properties => {};
}