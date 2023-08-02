import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herewego/pages/sign_in.dart';

import '../service/auth_service.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String id = 'splash_page';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
  }

  void _initTimer() {
    Timer(const Duration(seconds: 2), () {
      callNextPage();
    });
  }

  callNextPage() {
    if (AuthService.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, MainPage.id);
    } else {
      Navigator.pushReplacementNamed(context, SignIn.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Clone Version',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Text(
              'All rights reserved',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
