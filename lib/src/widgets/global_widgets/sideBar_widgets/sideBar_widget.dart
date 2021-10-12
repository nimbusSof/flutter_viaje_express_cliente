import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/services/signin/auth_service.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    final prefs = new PreferenciasUsuario();

    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        GestureDetector(
          onTap: () {
            mapaBloc.add(OnMapaCerrado());
            Navigator.pushReplacementNamed(context, 'perfil_inicio');
          },
          child: DrawerHeader(
            child: Container(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: grisColor,
                      radius: 30,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(
                        '${prefs.nombreUsuario} ${prefs.apellidoUsuario}',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        '${prefs.correoUsuario}',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300),
                      ),
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('sideBar.inicio'.tr()),
          onTap: () {
            mapaBloc.add(OnMapaCerrado());
            Navigator.pushReplacementNamed(context, 'inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text('sideBar.viajeNuevo'.tr()),
          onTap: () {
            mapaBloc.add(OnMapaCerrado());
            Navigator.pushReplacementNamed(context, 'loadingMapa');
          },
        ),
        ListTile(
          leading: Icon(Icons.save),
          title: Text('sideBar.destinosFav'.tr()),
          onTap: () {
            mapaBloc.add(OnMapaCerrado());
            Navigator.pushReplacementNamed(context, 'rutasGuardadas_inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.credit_card),
          title: Text('sideBar.metodoPago'.tr()),
          onTap: () {
            mapaBloc.add(OnMapaCerrado());
            Navigator.pushReplacementNamed(context, 'metodoPago_inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('sideBar.historial'.tr()),
          onTap: () {
            mapaBloc.add(OnMapaCerrado());
            Navigator.pushReplacementNamed(context, 'historialViajes_inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('sideBar.configuraciones'.tr()),
          onTap: () {
            mapaBloc.add(OnMapaCerrado());
            Navigator.pushReplacementNamed(context, 'configuraciones_inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('sideBar.salir'.tr()),
          onTap: () async{

            //al salir se restablecerá la aplicación con el idioma que tenga configurado
            //el dispositivo, ya que el idioma es una preferencia de usuario
            String idiomaDispositivo =
                          context.deviceLocale.toString().substring(0, 2);
                      print(idiomaDispositivo);
                      if(idiomaDispositivo=='es' || idiomaDispositivo=='en'){
                        await context.setLocale(Locale(idiomaDispositivo));
                      }else{
                        //se coloca idioma ingles por defecto
                        context.setLocale(context.locale);
                      }

            mapaBloc.add(OnMapaCerrado());
            authService.logout();
            


            Navigator.pushNamedAndRemoveUntil(
                context, 'signin', (route) => false);
          },
        )
      ]),
    );
  }
}
