import 'package:flutter/material.dart';

class LogoSplashScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height*0.30),
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage("assets/img_login/taxi_logo3.png"),
            width: 185.0,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 25.0),
          Text('Viaje Express', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
             fontSize: 35,
             color: Colors.white),)
        ],
      ),
    );
  }
}