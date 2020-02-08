import 'package:flutter/material.dart';

import "package:firebase_messaging/firebase_messaging.dart";
import "package:provider/provider.dart";

import "package:app/models/medication/medication_model.dart";

import "package:app/routes.dart";

// void main() => runApp(
//   MyApp()
// );
void main()
{
  runApp(
    ChangeNotifierProvider(
      create: (context) => MedicationModel(),
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes, // routes.dart
      initialRoute: splashPage, // routes.dart
      // home: MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

//   // @override
//   // initState()
//   // {
//   //   super.initState();
//   //   _firebaseMessaging.configure(
//   //     // Handle notifications when the app is in the background
//   //     onResume: (Map<String, dynamic> message) async {
//   //       print("Background notif: " + message.toString());

//   //     }
//   //   );
    
//   //   _firebaseMessaging.subscribeToTopic("test-topic");
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: Colors.lime,
//           width: 50,
//           height: 50
//         )
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
