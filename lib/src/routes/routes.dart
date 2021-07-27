import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/pages/configuraciones/configuraciones_inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/historialViajes/historialViajes_inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/inicio/inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/metodoPago/metodoPago_inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/login_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/signIn_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/splash_screen_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/rutasGuardadas/rutasGuardadas_inicio_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/'                            :  (_) => SplashScreen(),
  'login'                        :  (_) => LoginPage(),
  'signin'                       :  (_) => SignInPage(), 
  'inicio'                       :  (_) => InicioPage(),
  'metodoPago_inicio'            :  (_) => MetodoPagoInicioPage(),
  'historialViajes_inicio'       :  (_) => HistorialViajesInicioPage(),
  'configuraciones_inicio'       :  (_) => ConfiguracionesInicioPage(),
  'rutasGuardadas_inicio'        :  (_) => RutasGuardadasInicioPage(),
};
