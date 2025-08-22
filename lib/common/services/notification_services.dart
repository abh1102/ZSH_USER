import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/core/constants.dart';

import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/home/logic/provider/home_bottom_provider.dart';

class NotificationServices {
  final tabIndexProvider = Provider.of<TabIndexProvider>(Routes.currentContext);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    await AwesomeNotifications()
        .initialize('resource://drawable/notification_icon_white', [
      NotificationChannel(
        defaultColor: AppColors.primaryBlue,
        onlyAlertOnce: true,
        channelShowBadge: true,

        icon: 'resource://drawable/notification_icon_white',
        criticalAlerts: true,
        importance: NotificationImportance.Max,
        channelGroupKey: "high_importance_channel",
        channelKey: "high_importance_channel",
        channelName: "high_importance_channel",
        channelDescription: 'Default notification channel',
        // defaultColor: Colors.deepPurple,
        // ledColor: Colors.deepPurple,
      ),
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: message.notification!.android!.channelId.toString(),
          channelGroupName: "Group 1")
    ]);

    // handle interaction when app is active
    // ignore: use_build_context_synchronously
    handleMessage(context, message);
  }

  Future<void> firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('user denied permission');

        // ignore: use_build_context_synchronously
        showDialog(
          context: Routes.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Notification Permission Required",
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Please enable notification service otherwise you will not get any notification from our app",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Close"),
                ),
                TextButton(
                  onPressed: () {
                    AppSettings.openAppSettings();
                    Navigator.of(context).pop();
                  },
                  child: Text("Open Settings"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    final bool includeButtons = message.data['type'] == 'AI';
    if (includeButtons == true) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            color: AppColors.primaryBlue,
            actionType: ActionType.Default,
            badge: 1,
            icon: 'resource://drawable/notification_icon_white',
            criticalAlert: true,
            fullScreenIntent: true,
            wakeUpScreen: true,
            displayOnBackground: true,
            displayOnForeground: true,
            autoDismissible: false,
            channelKey: "high_importance_channel",
            groupKey: "high_importance_channel",
            category: NotificationCategory.Message,
            id: 1,
            title: message.notification!.title!,
            body: message.notification!.body!,
            notificationLayout: NotificationLayout.Default,
          ),
          actionButtons: [
            NotificationActionButton(
              key: 'BUTTON1',
              label: 'Button 1',
              autoDismissible: true,
              enabled: true,
            ),
            NotificationActionButton(
              key: 'BUTTON2',
              label: 'Button 2',
              autoDismissible: true,
              enabled: true,
            ),
            NotificationActionButton(
              key: 'BUTTON3',
              label: 'Button 3',
              autoDismissible: true,
              enabled: true,
            ),
          ]);
    } else {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          color: AppColors.primaryBlue,
          actionType: ActionType.Default,
          badge: 1,
          icon: 'resource://drawable/notification_icon_white',
          criticalAlert: true,
          fullScreenIntent: true,
          wakeUpScreen: true,
          displayOnBackground: true,
          displayOnForeground: true,
          autoDismissible: false,
          channelKey: "high_importance_channel",
          groupKey: "high_importance_channel",
          category: NotificationCategory.Message,
          id: 1,
          title: message.notification!.title!,
          body: message.notification!.body!,
          notificationLayout: NotificationLayout.Default,
        ),
      );
    }
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  Future<void> forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'SESSION') {
      // tabIndexProvider.setInitialTabIndex(0);
      // tabIndexProvider.setInitialTabIndex(2);
      // Routes.goTo(Screens.profile);
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      return androidDeviceInfo.id; // unique ID on Android
    }
  }
}
