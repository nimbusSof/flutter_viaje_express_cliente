import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/login_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/signIn_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login'         :  (_) => LoginPage(),
  'signin'        :  (_) => SignInPage(), 
};
