import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Ui/FirstPart/Splashscreen.dart';
import 'package:triple_n/Views/view_task.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    '260999', // id
    'nnn', // title
    'nnn description', // description
    importance: Importance.high,
    playSound: true);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// firebase background message handler

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
print("Background message "+message['data']['notification']);

//  if (message.containsKey('data')) {
//    final dynamic data = message['data'];
//  }
//
//  if (message.containsKey('notification')) {
//    final dynamic notification = message['notification'];
//
//  }
//

}

on_message_recieved(firebaseMessaging)
{
firebaseMessaging.configure
  (
    onMessage: (Map<String, dynamic> message) async
    {
      print("Message: $message");
      print('A new messageopen app event was published');
      var notification = message['notification'];
      print(notification);

      if (notification != null) {
        print("in notification");
        const NotificationDetails notificationDetails =
        NotificationDetails(android: AndroidNotificationDetails(
          "260999",
          "nnn",
          "nnn description",
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.white,
          playSound: true,
          icon: '@mipmap/ic_launcher',

//                icon: '@mipmap/ic_lancher',
        ),
          iOS: IOSNotificationDetails(),);
        await flutterLocalNotificationsPlugin.show(
            0,
            notification['title'],
            notification['body'], notificationDetails,
            payload: 'item x');

//
      }
    },

    onBackgroundMessage: _firebaseMessagingBackgroundHandler,

    onLaunch: (Map<String, dynamic> message) async // Called when app is terminated
        {
      print("onLaunch: $message");
      var notification = message['notification'];
      if (notification != null ) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification['title'],
            notification['body'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                "260999",
                "nnn",
                "nnn description",
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_lancher',
              ),
              iOS: IOSNotificationDetails(),
            ));
      }
    },
    onResume: (Map<String, dynamic> message) async
    {
      print("onResume: $message");
      var notification = message['notification'];
      if (notification != null ) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification['title'],
            notification['body'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                "260999",
                "nnn",
                "nnn description",
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_lancher',
              ),
              iOS: IOSNotificationDetails(),
            ));
      }
    }
);


}


void initializeNotification(context) async {
  try {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');


    Future onDidReceiveLocalNotification(int id, String title, String body,
        String payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => view_task(),
                      ),
                    );
                  },
                )
              ],
            ),
      );
    }

    Future<String> onSelectNotification(String payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      return  await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => view_task(),
        ),
      );
    }

    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
        initializationSettings, onSelectNotification: onSelectNotification);
  }
  catch (e) {
    print(e.toString());
  }
}



//

@override
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  on_message_recieved(firebaseMessaging);


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),);

  runApp(MyAPP());


}
class MyAPP extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    initializeNotification(context);
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    on_message_recieved(firebaseMessaging);


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:splashscreen(),
    );

  }
}













//  SharedPreferences.setMockInitialValues(<String, dynamic>{});
//  SharedPreferences.setMockInitialValues({});



//Future<void> _createNotificationChannel(String id, String name,
//    String description) async {
//  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//  var androidNotificationChannel = AndroidNotificationChannel(
//    id,
//    name,
//    description,
//  );
//  await flutterLocalNotificationsPlugin
//      .resolvePlatformSpecificImplementation<
//      AndroidFlutterLocalNotificationsPlugin>()
//      ?.createNotificationChannel(androidNotificationChannel);
//}

//await firebaseMessaging.setForegroundNotificationPresentationOptions(
//alert: true,
//badge: true,
//sound: true,
//);

//  _createNotificationChannel('260999','nnn','nnn');

//