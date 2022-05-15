import 'dart:async';

import 'package:ecosecha_flutter/app.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injectable.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SharedPreferences.getInstance();

      var apiClient = HttpApiClient();
      var authService = AuthService(apiClient: apiClient);

      configureDependencies();
      runApp(App(
        authService: authService,
        repository: Repository(apiClient: apiClient, authService: authService),
      ));
    },
    (error, st) => print(error),
  );
}
