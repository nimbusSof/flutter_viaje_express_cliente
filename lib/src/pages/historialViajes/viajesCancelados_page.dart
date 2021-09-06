import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class ViajesCanceladosPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'viajesCancelados';
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back, size: 30,color: grisOscuroColor,),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'historialViajes_inicio');
            }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Viajes Cancelados',
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
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          _historial()
        ],
      ),
    );
  }

  _historial() {
    return Expanded(
      child: ListView(
        children: _viajeCancelado(),
      ),
    );
  }

  _viajeCancelado() {
    List<Widget> lista = [];
    Widget viaje = ListTile(
      leading: Icon(
        Icons.cancel,
        color: Colors.red,
      ),
      title: Container(
        child: RichText(
            text: TextSpan(
                text: 'Mi casa\n',
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: [
              TextSpan(
                  text: 'Calle Uruguar 1-40',
                  style: TextStyle(color: Colors.black54, fontSize: 18))
            ])),
      ),
    );

    return lista
      ..add(viaje)
      ..add(Divider(
        thickness: 1.2,
      ))
      ..add(viaje)
      ..add(Divider(
        thickness: 1.2,
      ))
      ..add(viaje)
      ..add(Divider(
        thickness: 1.2,
      ));
  }
}