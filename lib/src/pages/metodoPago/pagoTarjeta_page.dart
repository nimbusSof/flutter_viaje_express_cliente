import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_selectDate.dart';

class PagoTarjetaPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'pagoTarjeta';
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back, size: 30, color: grisOscuroColor,),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'metodoPago_inicio');
            }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Agregar Tarjeta',
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
  final tarjetaCtrl = new TextEditingController();
  final fechaCtrl = new TextEditingController();
  final cvvCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              CustomInput(
                icon: Icons.credit_card,
                placeHolder: 'Número de tarjeta',
                textController: tarjetaCtrl,
                keyboardType: TextInputType.number,
              ),
              CustomSelectDate(inputFieldDataController: fechaCtrl, texto: 'Fecha de vencimiento',),
              CustomInput(
                icon: Icons.lock,
                placeHolder: 'Código de seguridad',
                textController: cvvCtrl,
                keyboardType: TextInputType.number,
              )
            ],
          ),
          CustomButton(text: 'Guardar', onPressed: () {})
        ],
      ),
    );
  }
}
