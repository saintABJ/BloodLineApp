import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:grazac_blood_line_app/ui/home_screen.dart';
import 'package:grazac_blood_line_app/ui/add_blood_sample.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Bloodline',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.red.shade900),
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = const Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (_) => const SignUp()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: Colors.red.shade900,
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
            Colors.red.shade900,
            Colors.white,
          ],
              stops: const <double>[
            0.5,
            0.5
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(color: Colors.black, blurRadius: 5)
            ], borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: Center(
              child: Column(
                children: [
                  const Image(image: AssetImage('images/bloodline_icon.png')),
                  Text(
                    'BloodLine',
                    style: TextStyle(
                        color: Colors.red.shade900,
                        fontSize: 28,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 2.0,
          )
        ],
      ),
    ));
  }
}
