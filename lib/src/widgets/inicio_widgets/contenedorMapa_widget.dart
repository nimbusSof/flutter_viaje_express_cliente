import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class ContenedorMapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('inicio.contenedor'.tr(), style: TextStyle(fontSize: 20),),
            ),
          ),   
          SizedBox(height: 10),
          Container(
            height: size.height*0.28,
            width: size.height*0.46,
            color: grisColor,
          ),
        ],
      ),
    );
  }
}
