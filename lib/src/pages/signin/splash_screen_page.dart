import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/themes/colors.dart' as colors;
import 'package:flutter_viaje_express_cliente/src/widgets/principal_widgets/splashScreen_widget/splash_screen_widget.dart';


class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacementNamed(context, 'login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [colors.yellowColor, colors.yellowColor],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter)),
        child: Center(
            child: LogoSplashScreen()
            ),
      ),
    );
  }


}
