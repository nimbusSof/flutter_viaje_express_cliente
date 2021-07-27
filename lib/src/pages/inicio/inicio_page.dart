import 'package:flutter/material.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/inicio_widgets/cabecera_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/inicio_widgets/contenedorMapa_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/inicio_widgets/custom_buttom_inicio.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/sideBar_widgets/sideBar_widget.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scafoldKey,
        drawer: SideBar(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(
          children: [
            _EstructuraPage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buttonDrawer(),
              ],
            ),
          ],
        ))));
  }

  Widget _buttonDrawer() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => _scafoldKey.currentState!.openDrawer(),
        icon: Icon(
          Icons.menu,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _EstructuraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Cabecera(
            titulo: 'Listos para un nuevo destino', subtitulo: 'Viaje Express'),
        BtnViajar(texto: '¿A dónde deseas ir?'),
        BtnRutasGuardadas(texto: 'Selecciona una ruta guardada'),
        SizedBox(height: 25),
        ContenedorMapa()
      ],
    );
  }
}
