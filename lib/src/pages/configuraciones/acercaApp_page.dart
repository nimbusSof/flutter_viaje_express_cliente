import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';

class AcercaAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Cambiar número',
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
        children: [
          SizedBox(height: 10,),
          BtnSimple(texto: 'Reglas del servicio'),
          BtnSimple(texto: 'Terminós y condiciones'),
          BtnSimple(texto: 'Política de privacidad'),
          BtnSimple(texto: 'Versión de la aplicación'),

        ],
      ),
    );
  }
}