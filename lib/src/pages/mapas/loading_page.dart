import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/helpers/helpers.dart';
import 'package:flutter_viaje_express_cliente/src/pages/mapas/acceso_gps_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/mapas/mapa_page.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

   @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.Geolocator.isLocationServiceEnabled()) { // verifica que el servicio GPS este habilitado
        Navigator.pushReplacement(context, navegarFadeIn(context, MapaPage()));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    // Persmisos GPS
    final permisoGps = await Permission.location.isGranted;
    // GPS está activo
    final gpsActivo = await Geolocator.Geolocator.isLocationServiceEnabled();

    if (permisoGps && gpsActivo) {
      Navigator.pushReplacement(context, navegarFadeIn(context, MapaPage()));
      return '';
    } else if (!permisoGps) {
      Navigator.pushReplacement(
          context, navegarFadeIn(context, AccesoGpsPage()));
      return 'Es necesario el permiso del GPS';
    } else {
      return 'Porfavor Activa el GPS';
    }

    //await Future.delayed(Duration(milliseconds: 100));

    // Navigator.pushReplacementNamed(context, navegarFadeIn(context, AccesoGpsPage()));
    //Navigator.pushReplacement(context, navegarFadeIn(context, MapaPage()));
  }
}
