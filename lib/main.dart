import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/views/screens/HomePage.dart';
import 'package:notekeeper/views/screens/notepage.dart';
import 'package:notekeeper/views/screens/signinpage.dart';
import 'package:notekeeper/views/screens/signuppage.dart';
import 'package:notekeeper/views/screens/splashscreen.dart';

import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: 'splash_screens',
      routes: {
        '/' : (context) => const Homepage(),
        'splash_screens' : (context) => const splash_screens(),
        'signinpage': (context) => const signinpage(),
        'signuppage':(context) => const signuppage(),
        'notepage':(context) => const notepage(),
      },
    ),
  );
}