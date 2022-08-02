import 'package:domain/domain.dart';

class AccountPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.accountPage;

  @override
  Map<String, dynamic> get properties => {};
}