import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/localization/supported_locales.dart';
import 'package:flutter_viaje_express_cliente/src/providers/perfil/datosConfPerfil_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/configuraciones/datosConfiguraciones_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/signin/forms_signIn_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/viajeNuevo/datosViajeNuevo_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/providers.dart';
import 'package:flutter_viaje_express_cliente/src/providers/viajeNuevo/slidingUpPanel_provider.dart';
import 'package:flutter_viaje_express_cliente/src/routes/routes.dart';
import 'package:flutter_viaje_express_cliente/src/services/perfil/updateCliente_service.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:provider/provider.dart';



void main() async {
  //instancias de shared preferences
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  //instancias de easy localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: supportedLocales,
      fallbackLocale: english,
      child: AppState()));
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
        ChangeNotifierProvider(create: (_) => new SlidingUpPanelProvider()),
        ChangeNotifierProvider(create: (_) => new UpdateClienteService()),
        ChangeNotifierProvider(create: (_) => new PreferenciasUsuario()),
        ChangeNotifierProvider(create: (_) => new DatosConfiguraciones()),
        ChangeNotifierProvider(create: (_) => new SignUpFormProvider()),
        ChangeNotifierProvider(create: (_) => new SignInFormProvider())
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
        BlocProvider(create: (_) => BusquedaBloc()),
      ],
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
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
