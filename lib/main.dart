import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/auth_screen/Login.dart';
import 'package:quizapp/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quizapp/screen/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Delay to show splash screen (optional)
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Handle loading state if needed
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              // User is logged in
              return HomePage(); // Navigate to HomePage
            } else {
              // User is not logged in
              return LoginPage(); // Navigate to LoginPage
            }
          }
        },
      ),
    );
  }
}
