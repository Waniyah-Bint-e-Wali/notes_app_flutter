import 'package:flutter/material.dart';
import 'package:notes_app_flutter/main.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:5),(){
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context)=>MyHomePage()
      )
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            color:Colors.blue.shade300,
                child:Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:300),
                    child: Column(
                      children: [
                        Container(
                          height:200,
                          width:200,
                          child:Image.asset("assets/images/notes 6.png")

                        ),
                        Container(
                          height:170,
                          width:200,
                            child:Center(child: Text("Good Notes",style:TextStyle(fontSize:42,fontFamily:'FontMain',fontWeight:FontWeight.w500,color:Colors.white)))
                        )
                      ],
                    ),
                  ),
                )
                )

    );
  }
}