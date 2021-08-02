import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/perfil_widgets/comentarios_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/perfil_widgets/ratingBar_widget.dart';

class ClasificacionPerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Clasificación de perfil',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black45,
          ),
        ),
      ),
      body: _EstructuraPage()
    );
  }
}

class _EstructuraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: size.height*0.06),
          child: Center(
            child: CircleAvatar(
              backgroundColor: grisOscuroColor,
              radius: 80,
            ),
          ),
        ),
        CustomRatingBar(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
          margin: EdgeInsets.symmetric(vertical: size.height*0.030),
          child: Divider(
            thickness: 1.2,
          )),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.height*0.035),
              margin: EdgeInsets.only(bottom: size.height*0.02),
              child: Text('Comentarios'),)),

        Comentarios()
      ],
    );
  }
}
