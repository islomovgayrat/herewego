import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/main_page.dart';
import 'package:herewego/pages/sign_in.dart';
import 'package:herewego/pages/sign_up.dart';
import 'package:herewego/pages/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      routes: {
        SplashPage.id: (_) => const SplashPage(),
        SignIn.id: (_) => const SignIn(),
        SignUp.id: (_) => const SignUp(),
        MainPage.id: (_) => const MainPage(),
      },
    );
  }
}
