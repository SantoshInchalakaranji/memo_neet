import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memo_neet/view/HomeScreen.dart';
import 'package:memo_neet/view/LoginScreen.dart';
import 'package:memo_neet/view/SignUpScreen.dart';
import 'package:memo_neet/view/SplashScreen.dart';
import 'package:memo_neet/viewmodel/AuthViewModel.dart';
import 'package:memo_neet/viewmodel/DataViewModel.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAVkKn6w75-cUhf0CXoaWhmxQB--6c1j9A",
              appId: "1:531350209966:android:5c4509b1bbff15fc04b43f",
              messagingSenderId: "531350209966",
              projectId: "memoneet-59084"))
      : Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => DataViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo Neet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future:
            Provider.of<AuthViewModel>(context, listen: true).checkLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            if (snapshot.hasData && snapshot.data == true) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }
        },
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
