import 'package:flutter/material.dart';
import 'package:projects/widget_tree.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) :super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate=false;
  @override
  void initState() {
       startAnimation();
  }
  @override

  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [

           AnimatedPositioned(
             duration: const Duration(milliseconds: 1600),
             top: animate? -200:-30,
               left: animate?-310:-140,
               child:AnimatedOpacity(
                   opacity: animate?1:0,
                   duration: const Duration(milliseconds:1600),
                 child: Image(
                     image: AssetImage('assets/nin.png')
                 ),
               )

           ),
          AnimatedPositioned(
            duration: const Duration(milliseconds:1600),
            bottom: animate? 40:-30,
            right: animate? -300:-40,
            child: AnimatedOpacity(
            opacity: animate? 1:0,
            duration: const Duration(milliseconds: 1600),
              child: Image(image: AssetImage('assets/2help.png')),
             )

          )
        ],
      ),
    );
  }

  Future startAnimation() async{
    await Future.delayed(Duration(milliseconds: 500));
    setState(()=> animate=true );
    await Future.delayed(Duration(milliseconds: 3000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const WidgetTree()));
  }


}