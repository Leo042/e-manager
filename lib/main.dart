import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spot_manager/chat/conversation_page.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/home_page.dart';
import 'package:spot_manager/pages/login_page.dart';


String _chatRoomId;
String fName;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _chatRoomId = message.data['chatRoomId'];
  fName = message.data['senderId'];

  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Models models = Models();
  bool _error = false;
  bool _initialized = false;


  @override
  void initState() {
    initializeflutter();
    super.initState();
    models.authenticate();
    var initializeSettingsAndriod = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializeSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializeSettingsAndriod,
      iOS: initializeSettingsIOS,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: onSelectNotification,
    );
  }

  void initializeflutter() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print('something went wrong');
      setState(() {
        _error = true;
      });
    }
  }

  // changetheme(bool value) {
  //   models.theme(value);
  //   setState(() {});
  //
  //   // if (models.themeColor == true) {
  //   //   models.theme(false);
  //   //   setState(() {});
  //   // } else {
  //   //   models.theme(true);
  //   //   setState(() {});
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error Message'),
              content: Text('Something went wrong'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Okay'),
                ),
              ],
            );
          });
      // return null;
    }
    if (!_initialized) {
      return MaterialApp(
        home: Scaffold(
          body: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    return ScopedModel<Models>(
      model: Models(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spot Manager',
        theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
//          primarySwatch: Colors.cyan,

        ),
        routes: {
          '/': (context) => ScopedModelDescendant<Models>(
            builder: (context, child, Models model) {
              model.authenticate();
              return Login();
            },
          ),
          'homepage': (context) => ScopedModelDescendant<Models>(
            builder: (context, child, Models model) {
              model.authenticate();
              return MyHomePage(model);
            },
          ),
          'message': (context) =>
              ContactUs(chatRoomId: _chatRoomId, userName: fName),
        },
      ),
    );
  }
}
