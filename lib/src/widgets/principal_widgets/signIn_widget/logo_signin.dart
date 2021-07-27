import 'package:flutter/material.dart';

class LogoSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Titulo(
          titulo: 'Viaje',
          fontSize: 60.0,
          estilo: FontWeight.bold,
          paddingRight: size.width * 0.5,
          top: 50.0,
        ),
        Titulo(
          titulo: 'Express',
          fontSize: 60.0,
          estilo: FontWeight.bold,
          paddingRight: size.width * 0.3,
          top: 2,
        ),
        Titulo(
          titulo: 'Registro',
          fontSize: 30.0,
          estilo: FontWeight.normal,
          paddingRight: size.width * 0.5,
          top: 30,
        )
      ],
    );
  }
}

class Titulo extends StatelessWidget {
  final String titulo;
  final double fontSize;
  final FontWeight estilo;
  final double paddingRight;
  final double top;

  const Titulo(
      {Key? key,
      required this.titulo,
      required this.fontSize,
      required this.estilo,
      required this.paddingRight,
      required this.top
      }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, this.paddingRight, 0.0),
      margin: EdgeInsets.only(top: top),
      child: Text(
        this.titulo,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: estilo,
        ),
      ),
    );
  }
}
