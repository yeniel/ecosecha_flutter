import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseView extends StatelessWidget {
  const BaseView({Key? key, required this.body, this.title}) : super(key: key);

  final Widget? title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: title
                ),
              body,
            ],
          ),
        ),
      ),
    );
  }
}
