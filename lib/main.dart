import 'package:ecosecha_flutter/app.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:flutter/material.dart';

import 'injectable.dart';

void main() {
  var apiClient = HttpApiClient();
  var authService = AuthService(apiClient: apiClient);

  configureDependencies();
  runApp(App(
    authService: authService,
    repository: Repository(apiClient: apiClient, authService: authService),
  ));
}
