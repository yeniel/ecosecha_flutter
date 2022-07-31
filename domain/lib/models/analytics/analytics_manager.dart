import 'package:domain/domain.dart';

abstract class AnalyticsManager {
  Future<void> init();
  Future<void> setUserId(String? userId);
  void logEvent(AnalyticsEvent event);
}