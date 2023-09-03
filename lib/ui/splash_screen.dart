import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsandriodproject/ui/home_screen.dart';




class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10), () {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> homeScreen()));

    });
  }

  @override

  Widget build(BuildContext context) {

    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/splash_pic.jpg',height: height*0.5,

              fit: BoxFit.cover,

            ),
            SizedBox(height: height*0.04,),
            Text("TOP HEADLINES -Created By Ahmad",style: GoogleFonts.anton(letterSpacing:.6,color: Colors.grey.shade700)),
            SizedBox(height: height*0.04,),
            SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
