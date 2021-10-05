import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/providers/datosConfiguraciones_provider.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:provider/provider.dart';

class CambiarIdiomaPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'cambiarIdioma';

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: grisOscuroColor,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'configuraciones_inicio');
            }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'configuraciones.idiomas.titulo'.tr(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.black45,
          ),
        ),
      ),
      body: _EstructuraPage(),
    ));
  }
}

class _EstructuraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datosConfi = Provider.of<DatosConfiguraciones>(context);
    inicializar(context);
    /* datosConfi.idioma1 = prefs.idioma1;
    datosConfi.idioma2 = prefs.idioma2; */

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          idioma('Español', datosConfi.idioma1, 1, context),
          idioma('Ingles', datosConfi.idioma2, 2, context),
        ],
      ),
    );
  }

  void inicializar(BuildContext context) async {
    final datosConfi = Provider.of<DatosConfiguraciones>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    String token = await authService.readToken();
    String idPersonarol = await authService.readIdPersonaRol();
    print('token inicializar: ' + token);
    datosConfi.inicializar(token, idPersonarol);
  }

  idioma(String texto, bool bandera, int numero, BuildContext context) {
    final prefs = new PreferenciasUsuario();
    final datosConfi = Provider.of<DatosConfiguraciones>(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 11),
        child: GestureDetector(
          onTap: () async {

            final authService =
              Provider.of<AuthService>(context, listen: false);
              String token = await authService.readToken();
              String idPersonarol = await authService.readIdPersonaRol();

            if (numero == 1) {
              datosConfi.putIdioma1(token, idPersonarol);
              await context.setLocale(Locale('es'));
            }
            if (numero == 2) {
              datosConfi.putIdioma2(token, idPersonarol);
              await context.setLocale(Locale('en'));
            }
          },
          child: RichText(
              text: TextSpan(
                  text: bandera == true ? 'Idioma seleccionado\n' : '',
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                  children: [
                TextSpan(
                    text: texto,
                    style: TextStyle(
                        color: bandera == true ? Colors.green : Colors.black87,
                        fontSize: 18))
              ])),
        ),
      ),
    );
  }

  /* idiomIngles() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 11),
        child: RichText(
            text: TextSpan(
                text: 'Idioma seleccionado\n',
                style: TextStyle(color: Colors.black87, fontSize: 18),
                children: [
              TextSpan(
                  text: 'Ingles',
                  style: TextStyle(color: Colors.green, fontSize: 18))
            ])),
      ),
    );
  } */

  /* idioma(texto) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 11, bottom: 11),
        child: TextButton(
            child: Text(texto,
                style: TextStyle(color: Colors.black87, fontSize: 19)),
            onPressed: () {}),
      ),
    );
  } */
}
