import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        GestureDetector(
          onTap: () {Navigator.popAndPushNamed(context, 'perfil_inicio');},
          child: DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img_util/menu-img.jpg'),
                    fit: BoxFit.cover)),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio'),
          onTap: () {
            Navigator.popAndPushNamed(context, 'inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Viaje Nuevo'),
          onTap: () {Navigator.popAndPushNamed(context, 'viajeNuevo_inicio');},
        ),
        ListTile(
          leading: Icon(Icons.save),
          title: Text('Rutas guardadas'),
          onTap: () {Navigator.popAndPushNamed(context, 'rutasGuardadas_inicio');},
        ),
        ListTile(
          leading: Icon(Icons.credit_card),
          title: Text('Payment'),
          onTap: () {
            Navigator.popAndPushNamed(context, 'metodoPago_inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('Historial de viajes'),
          onTap: () {
            Navigator.popAndPushNamed(context, 'historialViajes_inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Configuraciones'),
          onTap: () {
            Navigator.popAndPushNamed(context, 'configuraciones_inicio');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Salir'),
          onTap: () {
            Navigator.popAndPushNamed(context, 'login');
          },
        )
      ]),
    );
  }
}