import 'package:domain/domain.dart';

class OrderWebSiteTapEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.orderWebSiteTap;

  @override
  Map<String, dynamic> get properties => {};
}