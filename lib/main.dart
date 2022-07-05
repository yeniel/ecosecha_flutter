import 'dart:async';

import 'package:data/data.dart';
import 'package:ecosecha_flutter/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SharedPreferences.getInstance();

      var apiClient = HttpApiClient();
      var authRepository = AuthRepository(apiClient: apiClient);
      var repository = Repository(apiClient: apiClient, authRepository: authRepository);
      var productsRepository = ProductsRepository(repository: repository);

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => authRepository),
            RepositoryProvider(create: (context) => repository),
            RepositoryProvider(create: (context) => productsRepository),
            RepositoryProvider(create: (context) => UserRepository(repository: repository)),
            RepositoryProvider(create: (context) => CompanyRepository(repository: repository)),
            RepositoryProvider(
              create: (context) => OrderRepository(
                apiClient: apiClient,
                productsRepository: productsRepository,
                repository: repository,
              ),
            ),
          ],
          child: const App(),
        ),
      );
    },
    (error, st) => print(error),
  );
}
