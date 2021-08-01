import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class ClasificacionPerfil extends StatelessWidget {
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
      body: _EstructuraPage(),
    );
  }
}

class _EstructuraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 45),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: grisOscuroColor,
                    radius: 80,
                  ),
                ),
              ),

            ],
          ),
        ),
    ));
  }
}
