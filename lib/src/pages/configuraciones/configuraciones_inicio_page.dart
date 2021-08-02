import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/cabecera_widgets/cabecera_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/sideBar_widgets/sideBar_widget.dart';


class ConfiguracionesInicioPage extends StatefulWidget {
  

  @override
  _ConfiguracionesInicioPageState createState() => _ConfiguracionesInicioPageState();
}

class _ConfiguracionesInicioPageState extends State<ConfiguracionesInicioPage> {
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
        )))
    );
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
            titulo: 'Configuraciones', subtitulo: 'Viaje Express'),
        BtnSimple(texto: 'Cambiar número de teléfono', ruta: 'cambiarNumero',),
        BtnSimple(texto: 'Idioma',  ruta: 'cambiarIdioma',),
        BtnSimple(texto: 'Formato de fecha y distancia', ruta: 'cambiarFormatos', ),
        BtnSimple(texto: 'Acerca de la aplicación',  ),
        BtnSimple(texto: 'Cerrar sesión',  ),
      ],
    );
  }
}