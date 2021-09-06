import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/providers/datosConfPerfil_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/datosViajeNuevo_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/providers.dart';
import 'package:flutter_viaje_express_cliente/src/routes/routes.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new SignUpProvider()),
        ChangeNotifierProvider(create: (_) => new AuthService()),
        ChangeNotifierProvider(create: (_) => new CustomIputService()),
        ChangeNotifierProvider(create: (_) => new FormsCliente()),
        ChangeNotifierProvider(create: (_) => new DatosViajeNuevo()),
        ChangeNotifierProvider(create: (_) => new DatosConfPerfil()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MiUbicacionBloc()),
        BlocProvider(create: (_) => MapaBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Viaje Express',
        initialRoute:
            'checking', //ruta inicial debe ser el checking - loadingMapa
        routes: appRoutes,
        scaffoldMessengerKey: NotificationsService.messengerKey,
      ),
    );
  }
}
