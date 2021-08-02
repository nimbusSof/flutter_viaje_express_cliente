import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';

class CambiarNumeroPage extends StatelessWidget {
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
      ),
    );
  }
}

class _EstructuraPage extends StatelessWidget {
  final telefonoCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(size.height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            texto(),
            telefono(),
            boton()
          ],
        ));
  }

  texto() {
    return Container(
      child: RichText(
        text: TextSpan(
            text:
                'Al cambiar su número, su cuenta y sus datos se transferiran' +
                    'a su nuevo número',
            style: TextStyle(color: Colors.black54)),
      ),
    );
  }

  telefono() {
    return CustomInput(
      icon: Icons.phone,
      placeHolder: 'Su número de teléfono',
      textController: telefonoCtrl,
      keyboardType: TextInputType.phone,
    );
  }

  boton() {
    return CustomButton(text: 'Guardar', onPressed: () {});
  }
}
