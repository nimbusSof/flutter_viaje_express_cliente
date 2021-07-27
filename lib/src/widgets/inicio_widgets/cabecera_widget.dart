import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';


class Cabecera extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const Cabecera({required this.titulo, required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: size.height*0.159),
          decoration: BoxDecoration(color: yellowColor),
        ),
        LabelInicio(titulo: titulo, subtitulo: subtitulo)
      ],
    );
  }
}

class LabelInicio extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const LabelInicio({required this.titulo, required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(this.titulo,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.topLeft,
            child: Text(this.subtitulo,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w300)),
          )
        ],
      ),
    );
  }
}