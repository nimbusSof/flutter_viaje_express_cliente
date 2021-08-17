import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/routes/routes.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> new SignUpServide()),
        ChangeNotifierProvider(create: (_)=> new AuthService()),
        ChangeNotifierProvider(create: (_)=> new CustomIputService()),
        
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viaje Express',
      initialRoute: 'checking',
      routes: appRoutes,
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
