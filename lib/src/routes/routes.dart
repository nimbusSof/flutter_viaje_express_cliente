import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/pages/inicio/inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/metodoPago/metodoPago_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/login_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/signIn_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/splash_screen_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/'             :  (_) => SplashScreen(),
  'login'         :  (_) => LoginPage(),
  'signin'        :  (_) => SignInPage(), 
  'inicio'        :  (_) => InicioPage(),
  'metodoPago'    :  (_) => MetodoPagoPage(),
};
