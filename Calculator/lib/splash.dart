import 'package:flutter/material.dart';
import 'package:calculator/calculator.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget
{
	@override
	State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{

  Color c1 = const Color(0xff310131);
  Color c3 = const Color(0xfff24cb3);
  Color c4 = const Color(0xff9adb28);

	@override
	void initState()
  {
		super.initState();

		Timer(Duration(seconds: 2), ()
    {
			Navigator.pushReplacement( context , MaterialPageRoute(builder: (context) => Calculator() ));
		});
	}


	@override
	Widget build(BuildContext context)
  {

		return Scaffold(
      body:
      Container
      (
        child:
        Center
        (
          child:
          Text
          (
            "~ NightFalcon",
            style:
            TextStyle
            (
              fontSize: MediaQuery.of(context).size.shortestSide*0.14,
              color: c1,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.white,blurRadius: 10)]
            ),

          ),
        ),
        color: c3,
      )
    );
	}
}