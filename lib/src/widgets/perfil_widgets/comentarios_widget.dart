import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/themes/colors.dart';

class Comentarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 6, itemBuilder: (context, int index) => _ComentarioTile()),
    );
  }
}

class _ComentarioTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
          backgroundColor: grisOscuroColor,
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.symmetric(vertical: 7),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Carlos Andrade - Coop. 28 de Octubre\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'El cliente fue muy respetuoso y hasta me hizo la conversa, recomendadisimo el miji.')
          ], style: TextStyle(color: Colors.black))),
          decoration: BoxDecoration(
              // define las caracteristicas visuales del container
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black.withOpacity(0.0005),
                    offset: Offset(0, 5),
                    blurRadius: 1)
              ]),
        ),
      ),
    );
  }
}
