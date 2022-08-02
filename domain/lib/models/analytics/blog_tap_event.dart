import 'package:domain/domain.dart';

class BlogTapEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.blogTap;

  @override
  Map<String, dynamic> get properties => {};
}