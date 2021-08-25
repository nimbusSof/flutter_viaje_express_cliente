import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/helpers/helpers.dart';
import 'package:flutter_viaje_express_cliente/src/pages/mapas/acceso_gps_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/mapas/mapa_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    // TODO: Persmisos GPS
    // TODO: GPS está activo

    await Future.delayed(Duration(milliseconds: 100));
    print('loading page hola mundo');
    // Navigator.pushReplacementNamed(context, navegarFadeIn(context, AccesoGpsPage()));
    //Navigator.pushReplacement(context, navegarFadeIn(context, MapaPage()));
  }
}
