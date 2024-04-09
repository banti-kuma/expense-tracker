import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show File, Platform;
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class NotificationPlugin {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final BehaviorSubject<ReceivedNotification> didReceivedLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();

  NotificationPlugin() {
    init();
  }

  void init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  void initializePlatformSpecifics() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // final IOSIn initializationSettingsIOS = IOSInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: false,
    //   onDidReceiveLocalNotification: (id, title, body, payload) async {
    //     final receivedNotification = ReceivedNotification(
    //       id: id,
    //       title: title ?? "",
    //       body: body ?? "",
    //       payload: payload ?? "",
    //     );
    //     didReceivedLocalNotificationSubject.add(receivedNotification);
    //   },
    // );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void setListenerForLowerVersions(Function(ReceivedNotification) onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  Future<void> showNotification() async {
    final AndroidNotificationDetails androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: "channel_desc",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
      icon: "@mipmap/ic_launcher",
    );
    // final IOSNotificationDetails iosChannelSpecifics = IOSNotificationDetails(subtitle: "This is the subtitle in ios");
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
      // iOS: iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      1,
      'This title is for testing purpose in simple notification',
      'This body is for testing purpose in simple notification',
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }




  // Future<void> showDailyAtTime() async {
  //   final time = Time(21, 3, 0);
  //   final AndroidNotificationDetails androidChannelSpecifics = AndroidNotificationDetails(
  //     'CHANNEL_ID 4',
  //     'CHANNEL_NAME 4',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   final IOSNotificationDetails iosChannelSpecifics = IOSNotificationDetails();
  //   final NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidChannelSpecifics,
  //     iOS: iosChannelSpecifics,
  //   );
  //
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //     0,
  //     'Test Title at ${time.hour}:${time.minute}.${time.second}',
  //     'Test Body', //null
  //     time,
  //     platformChannelSpecifics,
  //     payload: 'Test Payload',
  //   );
  // }


  Future<int> getPendingNotificationCount() async {
    final p = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return p.length;
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _downloadAndSaveFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
  }
}

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
