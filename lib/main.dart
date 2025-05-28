import 'package:flutter/material.dart';
import 'package:pemesanandk/auth/auth.dart';
import 'package:lottie/lottie.dart';
import 'package:pemesanandk/misc/misc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    checkLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xFF1F5B85),
      child: Center(
        child: CircleAvatar(
          radius: 50,
          backgroundColor: const Color(0xFF1F5B85),
          child: Lottie.asset('assets/lottie/loadingscreen.json'),
        ),
      ),
    );
  }
}



