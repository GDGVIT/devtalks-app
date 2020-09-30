import 'package:devtalks/src/presentation/screens/auth/auth_screen.dart';
import 'package:devtalks/src/presentation/screens/landing/landing_screen.dart';
import 'package:devtalks/src/presentation/screens/main/base_screen.dart';
import 'package:devtalks/src/presentation/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _navigatorKey = GlobalKey<NavigatorState>();

  // _register() {
  //   _firebaseMessaging.getToken().then((token) => print(token));
  // }

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  Future<void> _showMyDialog(String title, String body) async {
    final _context = _navigatorKey.currentState.overlay.context;
    return showDialog<void>(
      context: _context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(body),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        _showMyDialog(
          message["notification"]["title"],
          message["notification"]["body"],
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'DevTalks',
      theme: lightTheme,
      home: LandingScreen(),
      routes: {
        LandingScreen.routename: (context) => LandingScreen(),
        AuthScreen.routename: (context) => AuthScreen(),
        BaseScreen.routename: (context) => BaseScreen(),
      },
    );
  }
}
