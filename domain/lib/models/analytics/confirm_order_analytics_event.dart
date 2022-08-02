import 'package:domain/domain.dart';

class ConfirmOrderAnalyticsEvent implements AnalyticsEvent {
  ConfirmOrderAnalyticsEvent({required this.success});

  late final bool success;

  @override
  String get name => AnalyticsEventName.confirmOrder;

  @override
  Map<String, dynamic> get properties => {};
}