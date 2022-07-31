import 'package:domain/domain.dart';

class OrderPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.orderPage;

  @override
  Map<String, dynamic> get properties => {};
}