import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/app.dart';
import 'package:ecosecha_flutter/firebase_options.dart';
import 'package:ecosecha_flutter/presentation/analytics/amplitude_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;


      var apiClient = HttpApiClient();
      var authRepository = AuthRepository(apiClient: apiClient);
      var repository = Repository(apiClient: apiClient, authRepository: authRepository);
      var productsRepository = ProductsRepository(repository: repository);
      var userRepository = UserRepository(repository: repository);
      var companyRepository = CompanyRepository(repository: repository);
      var analyticsManager = AmplitudeManager();

      await analyticsManager.init();

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => authRepository),
            RepositoryProvider(create: (context) => repository),
            RepositoryProvider(create: (context) => productsRepository),
            RepositoryProvider(create: (context) => userRepository),
            RepositoryProvider(create: (context) => companyRepository),
            // ignore: unnecessary_cast
            RepositoryProvider(create: (context) => analyticsManager as AnalyticsManager),
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
