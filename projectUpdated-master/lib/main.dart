import 'package:flutter/cupertino.dart';
import 'package:projects/pages/home_page.dart';
import 'package:projects/pages/CartPage.dart';
import 'package:projects/screen/splash_screen.dart';
import 'package:projects/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key?key}) : super(key:key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF6eb4d6),
      ),
      routes: {
        /*routes: {
        "/": (context)=>HomePage()
      },
        "/CartPage": (context)=>CartPage()
      */
      },
      home: SplashScreen(),
    );
  }
}

