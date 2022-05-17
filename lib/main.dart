import 'dart:async';

import 'package:ecosecha_flutter/app.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SharedPreferences.getInstance();

      var apiClient = HttpApiClient();
      var authService = AuthService(apiClient: apiClient);
      var repository = Repository(apiClient: apiClient, authService: authService);

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => authService),
            RepositoryProvider(create: (context) => repository),
          ],
          child: const App(),
        ),
      );
    },
    (error, st) => print(error),
  );
}
