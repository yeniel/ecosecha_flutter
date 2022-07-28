import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
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

      await AwesomeNotifications().initialize(
          null,
          [
            NotificationChannel(
                channelGroupKey: 'basic_channel_group',
                channelKey: 'basic_channel',
                channelName: 'Basic notifications',
                channelDescription: 'Notification channel for basic tests',
                defaultColor: Colors.green,
                ledColor: Colors.white)
          ],
          channelGroups: [
            NotificationChannelGroup(
                channelGroupkey: 'basic_channel_group',
                channelGroupName: 'Basic group')
          ],
          debug: true
      );

      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });

      var apiClient = HttpApiClient();
      var authRepository = AuthRepository(apiClient: apiClient);
      var repository = Repository(apiClient: apiClient, authRepository: authRepository);
      var productsRepository = ProductsRepository(repository: repository);
      var userRepository = UserRepository(repository: repository);
      var companyRepository = CompanyRepository(repository: repository);

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => authRepository),
            RepositoryProvider(create: (context) => repository),
            RepositoryProvider(create: (context) => productsRepository),
            RepositoryProvider(create: (context) => userRepository),
            RepositoryProvider(create: (context) => companyRepository),
            RepositoryProvider(
              create: (context) => OrderRepository(
                apiClient: apiClient,
                productsRepository: productsRepository,
                authRepository: authRepository,
                userRepository: userRepository,
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
