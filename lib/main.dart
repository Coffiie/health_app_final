import 'package:flutter/material.dart';
import 'package:health_app/providers/boarding_provider.dart';
import 'package:health_app/screen/boarding_screen.dart';
import 'package:health_app/screen/login_screen.dart';
import 'package:health_app/screen/register_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(create: (context)=>BoardingEvent(), child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}