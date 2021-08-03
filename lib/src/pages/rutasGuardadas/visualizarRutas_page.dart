import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class VisualizarRutasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Viajes Concluidos',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black45,
          ),
        ),
      ),
      body: _EstructuraPage(),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: yellowColor,
      ),
    ));
  }
}

class _EstructuraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          _rutas()
        ],
      ),
    );
  }

  _rutas() {
    return Expanded(
      child: ListView(
        children: rutasGuardadas(),
      ),
    );
  }

  rutasGuardadas() {
    List<Widget> lista = [];
    Widget viaje = ListTile(
      leading: Icon(
        Icons.stars,
      ),
      title: Container(
        child: RichText(
            text: TextSpan(
                text: 'Mi casa\n',
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: [
              TextSpan(
                  text: 'Calle Uruguar 1-40',
                  style: TextStyle(color: Colors.black54, fontSize: 18))
            ])),
      ),
    );

    return lista
      ..add(viaje)
      ..add(Divider(
        thickness: 1.2,
      ))
      ..add(viaje)
      ..add(Divider(
        thickness: 1.2,
      ))
      ..add(viaje)
      ..add(Divider(
        thickness: 1.2,
      ));
  }
}
