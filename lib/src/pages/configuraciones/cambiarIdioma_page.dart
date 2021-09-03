import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class CambiarIdiomaPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'cambiarIdioma';
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back, size: 30,color: grisOscuroColor,),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'configuraciones_inicio');
            }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Idioma',
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
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          idiomaPredeterminado(),
          idioma('Ingles'),
          idioma('Portugues'),
          idioma('Frances'),
        ],
      ),
    );
  }

  idiomaPredeterminado() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 11),
        child: RichText(
            text: TextSpan(
                text: 'Idioma predeterminado\n',
                style: TextStyle(color: Colors.black87, fontSize: 18),
                children: [
              TextSpan(text: 'Español', style: TextStyle(color: Colors.green, fontSize: 18))
            ])),
      ),
    );
  }

  idioma(texto) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 11, bottom: 11),
        child: Text(texto, style: TextStyle(color: Colors.black87, fontSize: 18)),
      ),
    );
  }
}
