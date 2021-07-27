import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viaje Express',
      initialRoute: 'metodoPago',
      routes: appRoutes,
    );
  }
}