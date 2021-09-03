import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class PagoEfectivoPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'pagoEfectivo';
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back, size: 30,color: grisOscuroColor,),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'metodoPago_inicio');
            }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Efectivo',
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
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Efectivo',
                style: TextStyle(fontSize: 55, color: Colors.black),
              ),
            ),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: 'Paga tus viajes en efectivo\n',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  'El teléfono de tu conductor te mostrará el monto a pagar al final del viaje.',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ]))
        ],
      ),
    );
  }
}
