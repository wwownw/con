import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'fbmessaging.dart';
import 'notificationbadge.dart';

class NotificationTest extends StatefulWidget {
  const NotificationTest({Key? key}) : super(key: key);

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  //initialize some value
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;
  //model
  PushNotification? _notificationInfo;

  //register notification
  void registerNotification() async {
    await Firebase.initializeApp();
    //instance for firebase messaging
    _messaging = FirebaseMessaging.instance;

    //three type of state in notification
    //not determinded (null), granted (true), and decline (false)

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("사용자가 알림 사용 권한을 부여했습니다.");

      //main message

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          message.notification!.title,
          message.notification!.body,
          message.data['title'],
          message.data['body'],
        );
        setState(() {
          _totalNotificationCounter++;
          _notificationInfo = notification;
        });

        if (notification != null) {
          showSimpleNotification(Text(_notificationInfo!.title!),
              leading: NotificationBadge(
                  totalNotification: _totalNotificationCounter),
              subtitle: Text(_notificationInfo!.body!),
              background: Colors.lightGreen.shade300,
              duration: const Duration(seconds: 2));
        }
      });
    } else {
      print("사용자가 알림 사용 권한을 거부했습니다.");
    }
  }

  @override
  void initState() {
    registerNotification();
    _totalNotificationCounter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NotificationBadge(totalNotification: _totalNotificationCounter),
            const SizedBox(height: 10),
            if (_notificationInfo != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Title : ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                      'Title : ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
