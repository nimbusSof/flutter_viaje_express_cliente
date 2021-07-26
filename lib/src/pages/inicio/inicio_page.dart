import 'package:flutter/material.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/inicio_widgets/cabecera_widget.dart';

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _EstructuraPage());
  }
}


class _EstructuraPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Cabecera(
            titulo: 'Listos para un nuevo destino', subtitulo: 'Viaje Express')
      ],
    );
  }
}


