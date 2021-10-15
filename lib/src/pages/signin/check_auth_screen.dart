import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_viaje_express_cliente/src/pages/inicio/inicio_page.dart';

import 'package:flutter_viaje_express_cliente/src/pages/signin/signIn_page.dart';
import 'package:flutter_viaje_express_cliente/src/services/signin/auth_service.dart';

import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final prefs = new PreferenciasUsuario();

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Text('Espere');
            }
            // si regrsa cadena vacía es porque no tiene el token de autenticacion guardado
            //es decir, no ha iniciado sesion
            
            if (snapshot.data == '') {

              //insernacionalización de la app según el idioma del dispositivo
              String idiomaDispositivo =
                  context.deviceLocale.toString().substring(0, 2);

              if (idiomaDispositivo == 'es' || idiomaDispositivo == 'en') {
                context.setLocale(Locale(idiomaDispositivo));
              }else{
                context.setLocale(Locale('en'));
              }
              

              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SignInPage(),
                        transitionDuration: Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() async {
                Navigator.of(context).pushReplacementNamed(
                    prefs.ultimaPagina == '' ? 'inicio' : prefs.ultimaPagina);
                /* Navigator.pushReplacement(
                  context, PageRouteBuilder(
                    pageBuilder: (_,__,___)=>InicioPage(),
                    transitionDuration: Duration(seconds: 0))); */
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
